plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")

    // 1. Add the Google services Gradle plugin here
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.untitled"
    compileSdk = flutter.compileSdkVersion

    // *** FIX: Set NDK Version to satisfy Firebase requirements ***
    ndkVersion = "27.0.12077973"

    compileOptions {
        // FIX: Ensure Java version is explicitly set to 11 to resolve "source value 8 is obsolete" warnings
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.LUI.anonca"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.

        // *** FIX: Set minSdk to 23 to satisfy Firebase requirements ***
        minSdk = 23

        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// 2. Add the dependencies block at the end of the file
dependencies {
    // Import the Firebase BoM (Bill of Materials)
    // This manages all Firebase library versions for consistency.
    implementation(platform("com.google.firebase:firebase-bom:34.4.0"))

    // Add the dependencies for Firebase products you want to use.
    // Firebase-analytics is the standard requirement.
    implementation("com.google.firebase:firebase-analytics")

    // Example: implementation("com.google.firebase:firebase-auth")
}
