# Docker Volume with Android SDK

Use this image as volume where you need an android SDK or inherit from this image.

Either inherit, use in your Dockerfile:
    FROM mwaeckerlin/android-sdk

Or link it as volume: `docker run --volumes-from your-android-sdk-container [...]` and in your Dockerfile use:
    ENV ANDROID_HOME /android
    VOLUME /android

Updates the Android SDK on each restart.
