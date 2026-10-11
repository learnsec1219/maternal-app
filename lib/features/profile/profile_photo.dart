import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/storage/local_store.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/models.dart';
import '../patient/patient_data.dart';

/// Picks a photo from the phone's gallery and keeps a copy in the app's own
/// folder, so it is still there after the gallery item is moved or deleted.
abstract class PhotoSource {
  /// The saved file's path, or null when the person backs out.
  Future<String?> pickFromGallery(String personId);
}

class GalleryPhotoSource implements PhotoSource {
  @override
  Future<String?> pickFromGallery(String personId) async {
    // Android shows its own photo picker, which only shares the one photo
    // chosen; older phones ask for gallery access the first time.
    final x = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (x == null) return null;
    final dir = await getApplicationDocumentsDirectory();
    final ext = x.path.contains('.') ? x.path.split('.').last : 'jpg';
    final file = File(
      '${dir.path}/profile_${personId}_'
      '${DateTime.now().millisecondsSinceEpoch}.$ext',
    );
    await file.writeAsBytes(await x.readAsBytes());
    return file.path;
  }
}

final photoSourceProvider = Provider<PhotoSource>(
  (ref) => GalleryPhotoSource(),
);

/// Each person's chosen photo, kept on this phone across sign-outs and
/// restarts.
final profilePhotosProvider =
    NotifierProvider<ProfilePhotos, Map<String, String>>(ProfilePhotos.new);

class ProfilePhotos extends Notifier<Map<String, String>> {
  static const _key = 'profile.photos';

  @override
  Map<String, String> build() => {
    for (final e
        in (ref.read(localStoreProvider).readMap(_key) ?? const {}).entries)
      if (e.value is String) e.key: e.value as String,
  };

  Future<void> set(String personId, String? path) async {
    final old = state[personId];
    state = {
      for (final e in state.entries)
        if (e.key != personId) e.key: e.value,
      personId: ?path,
    };
    await ref.read(localStoreProvider).writeJson(_key, state);
    if (old != null && old != path && !old.startsWith('http')) {
      try {
        await File(old).delete();
      } on Object {
        // Already gone.
      }
    }
  }
}

/// The photo to show for [p]: one they chose here, else their Google photo.
String? photoOf(WidgetRef ref, Profile p) =>
    ref.watch(profilePhotosProvider)[p.id] ?? p.photoUrl;

/// The big profile avatar with a camera badge; tapping it offers to choose
/// a photo from the gallery or remove the current one.
class EditableAvatar extends ConsumerWidget {
  const EditableAvatar({super.key, required this.me});
  final Profile me;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, scheme = Theme.of(context).colorScheme;
    final photo = photoOf(ref, me);
    final hasOwn = ref.watch(profilePhotosProvider).containsKey(me.id);

    Future<void> choose() async {
      final path = await ref.read(photoSourceProvider).pickFromGallery(me.id);
      if (path == null) return;
      await ref.read(profilePhotosProvider.notifier).set(me.id, path);
      if (context.mounted) showToast(context, l.photoSaved);
    }

    Future<void> openMenu() => showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              key: const Key('photo-gallery'),
              leading: const Icon(Icons.photo_library_outlined),
              title: OneLine(l.photoChoose),
              onTap: () {
                Navigator.pop(ctx);
                choose();
              },
            ),
            if (hasOwn)
              ListTile(
                key: const Key('photo-remove'),
                leading: const Icon(Icons.delete_outline_rounded),
                title: OneLine(l.photoRemove),
                onTap: () {
                  Navigator.pop(ctx);
                  ref.read(profilePhotosProvider.notifier).set(me.id, null);
                },
              ),
          ],
        ),
      ),
    );

    return Semantics(
      button: true,
      label: l.photoChange,
      child: InkWell(
        key: const Key('profile-photo'),
        customBorder: const CircleBorder(),
        onTap: openMenu,
        child: Stack(
          children: [
            Avatar(me.name, size: 80, photoUrl: photo),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: scheme.primary, width: 1.5),
                ),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 16,
                  color: scheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
