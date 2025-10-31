# RunnerPrime (Flutter Port)

Prototype slice: Auth + Home + Run (live map + 100m tiles)

## Prerequisites
- Flutter 3.24+
- Android SDK
- Firebase project (same as iOS backend)

## Setup
1) Generate Firebase options
- Install FlutterFire CLI and run:
  - `flutterfire configure --project <your-firebase-project>`
- Replace `lib/core/services/firebase_options.dart` with generated file.

2) Google services
- Add `android/app/google-services.json` (Android) and enable Google services plugin in `build.gradle`.

3) Google Maps key
- Create Android API key and place in `AndroidManifest.xml` as meta-data `com.google.android.geo.API_KEY`.

4) Permissions
- Location permissions required. On Android 10+, consider background location for continuous tracking.

## Run
- `flutter pub get`
- `flutter test` (unit/widget)
- `flutter test integration_test` (integration)
- `flutter run`

## Android Releases (GitHub)
- Tag the repository with `v*` (e.g. `v0.1.0`) -> CI builds and attaches a debug APK in GitHub Releases.
- Workflow: `.github/workflows/release-apk.yml`

## iOS TestFlight (CI)
- Workflow: `.github/workflows/ios-testflight.yml` (manual trigger)
- Required GitHub Secrets:
  - `ASC_KEY_ID` (App Store Connect API key ID)
  - `ASC_ISSUER_ID` (App Store Connect issuer ID)
  - `ASC_KEY_BASE64` (Base64 content of `.p8` key)
- Update `ios/fastlane/Appfile` with your bundle id and Apple ID.
- Trigger the workflow from the Actions tab to upload to TestFlight.

## Performance
- See `tool/ci/device_matrix.md` for devices and `tool/ci/perf_notes.md` for steps.
- Build size: use `flutter build apk --analyze-size`; enable ABI splits in Gradle.
- Monitor jank while panning/recording in `--profile` mode.

## Notes
- Health data parity deferred to Phase 2 via `health` (Google Fit).
- Background location deferred; evaluate `background_locator_2`.
