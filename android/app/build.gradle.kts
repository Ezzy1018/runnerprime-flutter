plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.runnerprime_flutter"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.runnerprime_flutter"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
}

dependencies {
}
