import 'package:flutter/material.dart';

import '../../features/settings/language_switcher.dart';
import '../theme/app_theme.dart';
import '../util/l10n.dart';

/// White rounded card with a hairline border, like the demo's `.card`.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.margin = const EdgeInsets.only(bottom: 12),
  });

  final Widget child;
  final Color? color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Padding(
      padding: margin,
      child: Material(
        color: color ?? p.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: p.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

enum Tone { info, warn, alert, good }

/// Tinted note with a leading mark, like the demo's `.banner`.
class InfoBanner extends StatelessWidget {
  const InfoBanner(
    this.message, {
    super.key,
    this.title,
    this.tone = Tone.info,
  });

  final String message;
  final String? title;
  final Tone tone;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    final bg = switch (tone) {
      Tone.info => p.sky,
      Tone.warn => p.warnSoft,
      Tone.alert => p.alertSoft,
      Tone.good => p.goodSoft,
    };
    final mark = switch (tone) {
      Tone.info => 'i',
      Tone.good => '✓',
      _ => '!',
    };
    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExcludeSemantics(
              child: Text(
                mark,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        title!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 13.5, height: 1.45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section title with an optional action on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(2, 14, 2, 8),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        ?action,
      ],
    ),
  );
}

/// Small rounded label.
class Pill extends StatelessWidget {
  const Pill(
    this.text, {
    super.key,
    this.background,
    this.foreground,
    this.icon,
  });

  final String text;
  final Color? background, foreground;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    // Never wider than half the screen, so it fits beside a title in a row;
    // a long label (e.g. in Tamil) wraps onto a second line instead.
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: background ?? p.roseSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        icon == null ? text : '$icon $text',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: foreground ?? p.ink,
        ),
      ),
    );
  }
}

/// A form label written above its input, so long labels in any language wrap
/// onto the next line instead of being cut off inside the box.
class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.child,
    this.helper,
    this.error,
  });

  final String label;
  final Widget child;
  final String? helper, error;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 4),
            child: Text(
              label,
              style: TextStyle(fontSize: 12.5, color: p.muted),
            ),
          ),
          child,
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 4),
              child: Text(
                error!,
                style: TextStyle(fontSize: 12.5, color: p.alert),
              ),
            )
          else if (helper != null)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: Text(
                helper!,
                style: TextStyle(fontSize: 12.5, color: p.muted),
              ),
            ),
        ],
      ),
    );
  }
}

/// Text input with its label above it.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.hint,
    this.helper,
    this.error,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.fieldKey,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hint, helper, error;
  final bool enabled;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) => LabeledField(
    label: label,
    helper: helper,
    error: error,
    child: TextField(
      key: fieldKey,
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(hintText: hint),
    ),
  );
}

/// Single-choice chips that wrap onto as many lines as they need.
class ChoiceChips<T> extends StatelessWidget {
  const ChoiceChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<(T, String)> options;
  final T? selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (value, label) in options)
          SelectChip(
            label: label,
            selected: value == selected,
            onTap: () => onSelected(value),
          ),
      ],
    ),
  );
}

class SelectChip extends StatelessWidget {
  const SelectChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? p.roseSoft : p.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: selected ? p.rose : p.line),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded icon square used on tiles and rows.
class TileIcon extends StatelessWidget {
  const TileIcon(
    this.icon, {
    super.key,
    required this.background,
    this.size = 30,
    this.color,
  });

  final IconData icon;
  final Color background;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(size / 3),
    ),
    child: Icon(icon, size: size * 0.58, color: color ?? context.pal.ink),
  );
}

/// Full-width primary button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton(
      style: color == null
          ? null
          : FilledButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(label, textAlign: TextAlign.center),
      ),
    ),
  );
}

/// Full-width outlined button.
class GhostButton extends StatelessWidget {
  const GhostButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      style: color == null
          ? null
          : OutlinedButton.styleFrom(foregroundColor: color),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 10),
            ],
            Flexible(child: Text(label, textAlign: TextAlign.center)),
          ],
        ),
      ),
    ),
  );
}

/// Soft tonal button that sizes to its label.
class TonalButton extends StatelessWidget {
  const TonalButton(this.label, {super.key, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: p.roseSoft,
        foregroundColor: p.ink,
        minimumSize: const Size(0, 40),
      ),
      onPressed: onPressed,
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}

class EmptyNote extends StatelessWidget {
  const EmptyNote(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: context.pal.muted, fontSize: 13.5),
    ),
  );
}

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(6, 8, 6, 4),
    child: Text(
      context.l10n.disclaimer,
      textAlign: TextAlign.center,
      style: TextStyle(color: context.pal.muted, fontSize: 11.5, height: 1.5),
    ),
  );
}

/// A row in a list card: icon, text, optional trailing.
class ListRow extends StatelessWidget {
  const ListRow({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.divider = true,
    this.strike = false,
  });

  final Widget? leading, trailing;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool divider, strike;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: divider ? Border(top: BorderSide(color: p.line)) : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 2),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: strike ? p.muted : null,
                      decoration: strike ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(fontSize: 12.5, color: p.muted),
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              // Long trailing text (dates, pills) shrinks instead of overflowing.
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(fit: BoxFit.scaleDown, child: trailing!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A list of [ListRow]s inside a card, without a line above the first.
class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.rows});
  final List<ListRow> rows;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    child: Column(
      children: [
        for (var i = 0; i < rows.length; i++)
          ListRow(
            leading: rows[i].leading,
            title: rows[i].title,
            subtitle: rows[i].subtitle,
            trailing: rows[i].trailing,
            onTap: rows[i].onTap,
            strike: rows[i].strike,
            divider: i > 0,
          ),
      ],
    ),
  );
}

/// Standard pushed page: back arrow, title, language switcher, scrolling body
/// and an optional pinned bottom button.
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.children,
    this.bottom,
    this.showLanguage = false,
    this.leading,
    this.actions = const [],
  });

  final String title;
  final List<Widget> children;
  final Widget? bottom, leading;
  final bool showLanguage;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: leading,
      title: Text(title, maxLines: 2),
      actions: [
        ...actions,
        if (showLanguage) const LanguageSwitcher(),
        const SizedBox(width: 6),
      ],
    ),
    body: SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              children: children,
            ),
          ),
          if (bottom != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: bottom,
            ),
        ],
      ),
    ),
  );
}

/// Two equal columns that grow with their content (no fixed heights).
class TwoColumn extends StatelessWidget {
  const TwoColumn({super.key, required this.children, this.gap = 10});
  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < children.length; i += 2)
        Padding(
          padding: EdgeInsets.only(bottom: i + 2 < children.length ? gap : 0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: children[i]),
                SizedBox(width: gap),
                Expanded(
                  child: i + 1 < children.length
                      ? children[i + 1]
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1800),
      ),
    );
}
