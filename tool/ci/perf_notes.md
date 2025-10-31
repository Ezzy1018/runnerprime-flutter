Performance checklist (to run on devices):

- Startup time: `flutter run --profile` and Observatory timeline.
- Jank: Monitor `flutter run --profile` frame chart while panning map and recording.
- Memory: Android Studio Profiler during 15-minute run.
- Binary size: `flutter build apk --analyze-size`.
- APK splits: enable `abiSplit` in Gradle; verify per-ABI sizes.

