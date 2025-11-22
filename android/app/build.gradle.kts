plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fitmind_plus"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.fitmind_plus"
        minSdk = 21
        targetSdk = 34

        val localProps = java.util.Properties().apply {
            val f = file("${rootDir}/local.properties")
            if (f.exists()) f.inputStream().use { load(it) }
        }
        val flutterVersionCode = (localProps.getProperty("flutter.versionCode") ?: "1").toInt()
        val flutterVersionName = localProps.getProperty("flutter.versionName") ?: "1.0"

        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    packaging {
        resources {
            excludes += setOf(
                "META-INF/AL2.0",
                "META-INF/LGPL2.1"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Kendi ek bağımlılıklarını buraya ekle
}
