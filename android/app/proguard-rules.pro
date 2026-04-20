# Keep Flutter engine and plugin classes used by reflection.
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Preserve Firebase initialization/runtime classes.
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**
