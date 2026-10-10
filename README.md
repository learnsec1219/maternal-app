# Maternal

Women's health, pregnancy and cycle companion app for Android and iOS, built with Flutter.
This is the first working skeleton, rebuilt from the original HTML prototype.

## What works today

- **5-tab navigation:** Home, Calendar, Create (centre button), Calories, Profile.
- **Create menu:** health log (blood pressure, weight, heart rate, glucose, temperature, SpO2, sleep, water, fetal movements), symptoms with warning-sign guidance, period, meal. Vaccine, appointment and document entries are placeholders.
- **Home:** pregnancy overview (gestational age, due date, countdown, trimester) or cycle overview, today's health cards, tasks, recent activity, warning signs.
- **Calendar:** swipeable month view with logged periods, predicted period, fertile window and ovulation estimates, day details, and a pregnancy timeline when pregnant.
- **Calories:** daily target (estimate, or a target set by the care team), consumed and remaining, meals with macros.
- **Profile:** personal, body and pregnancy details, activity level, patient / doctor role.
- **Doctor dashboard:** summary stats and a searchable patient list using demo data.
- **Languages:** English, Traditional Chinese, Bahasa Melayu, switchable from the top-right.

Data is stored only on the device for now and is **not encrypted**. Don't enter real patient data until the security step is done.

## Try it on an Android phone

Every push builds a debug APK in GitHub Actions:

1. Open the **Actions** tab, pick the latest green **Android build** run.
2. Download the `maternal-debug-apk` artifact and unzip it.
3. Copy `app-debug.apk` to the phone and open it. Android will ask you to allow installs from that source.

## Run it locally

Install Flutter 3.47+ and Android Studio (with an Android emulator), then:

```sh
flutter pub get
flutter run          # picks the running emulator or a USB-connected phone
flutter test
```

## Project layout

```
lib/
  app.dart, main.dart       app setup, theme, localization
  core/                     theme, local storage, shared widgets, helpers
  features/<feature>/
    domain/                 models and pure logic (gestation, cycle predictions, calorie targets)
    application/            Riverpod state controllers
    presentation/           screens and forms
  l10n/                     app_en.arb, app_zh.arb, app_ms.arb (all UI text)
```

To add or change text, edit the `.arb` files in `lib/l10n/`; Flutter regenerates the code on build.

## Branding

The official logo is a mother cradling her baby, with a heart between them, in the app's soft rose palette.

- `assets/branding/maternal-logo.png`: full logo with the "Maternal" wordmark (1024 x 1024).
- `assets/branding/maternal-icon.png`: icon mark only, the master for the app icons (1024 x 1024).

The Android launcher icons (including the adaptive icon) and the iOS app icons are generated from the icon master.

## Next steps

Onboarding and login, vaccines, appointments and documents, encrypted local database, backend and doctor access, notifications, wearables / Health Connect, then Play Store release.
