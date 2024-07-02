# Preserve all classes in the Firebase package.
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Preserve the names of all classes in the Firebase package.
-keepnames class com.google.firebase.** { *; }
-keepnames class com.google.android.gms.** { *; }

# Do not warn about missing classes in the Firebase package.
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Keep the members annotated with @PropertyName used by Firestore models.
-keepclassmembers class * {
    @com.google.firebase.firestore.PropertyName <fields>;
}

# Specific rule to keep the names of fields and methods in classes annotated with @Keep.
-keep class * {
    @com.google.firebase.firestore.IgnoreExtraProperties *;
}

# Firebase Analytics
-keep class com.google.android.gms.measurement.** { *; }
-dontwarn com.google.android.gms.measurement.**

# Firebase Firestore related classes
-keep class com.google.firebase.firestore.** { *; }
-dontwarn com.google.firebase.firestore.**

# Prevent stripping of the JSON parser used by Firebase
-keepattributes Signature
-keepattributes *Annotation*
-keepclassmembers class ** {
    @com.google.gson.annotations.SerializedName <fields>;
}
-keep class com.google.gson.** { *; }

# Prevent stripping of the Realm and other libraries used with Firebase
-keepclassmembers class * {
    @io.realm.annotations.RealmModule *;
}
-dontwarn io.realm.**

# Additional rules for other Firebase services (optional, based on your usage)
# Firebase Cloud Messaging
-keep class com.google.firebase.messaging.** { *; }
-dontwarn com.google.firebase.messaging.**

# Firebase Auth
-keep class com.google.firebase.auth.** { *; }
-dontwarn com.google.firebase.auth.**

# Firebase Crashlytics
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# Retrofit (if used with Firebase for network calls)
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# OkHttp (if used)
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Gson (if used)
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Prevent R8 from stripping logging classes (optional)
-assumenosideeffects class android.util.Log {
    public static int v(...);
    public static int d(...);
    public static int i(...);
    public static int w(...);
    public static int e(...);
}
