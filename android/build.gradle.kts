plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.kapt")
}

group = "com.file.downloader"
version = "1.0-SNAPSHOT"

android {
    namespace = "com.file.downloader"

    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }


    sourceSets {
        getByName("main") {
            java.srcDir("src/main/kotlin")
        }
        getByName("test") {
            java.srcDir("src/test/kotlin")
        }
    }

    defaultConfig {
        minSdk = 23
    }

    testOptions {
        unitTests.all {
            useJUnitPlatform()

            testLogging {
                events(
                        "passed",
                        "skipped",
                        "failed",
                        "standardOut",
                        "standardError"
                )
                showStandardStreams = true
            }

            outputs.upToDateWhen { false }
        }
    }
}

dependencies {
    testImplementation("org.jetbrains.kotlin:kotlin-test")
    testImplementation("org.mockito:mockito-core:5.4.0")

    api("org.greenrobot:eventbus:3.3.1")
    kapt("org.greenrobot:eventbus-annotation-processor:3.3.1")
}