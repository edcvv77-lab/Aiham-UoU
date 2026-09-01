# Firebase activation

The debug build runs in local demo mode until Firebase is configured.

## Required configuration

1. Create a Firebase project.
2. Add an Android application with package name `com.aiham.uou`.
3. Put `google-services.json` at `mobile/android/app/google-services.json`.
4. Enable Firebase Authentication and Cloud Firestore.
5. Deploy `firebase/firestore.rules`.
6. Enable Firestore TTL for the collection group `messages` using the field `expireAt`.

The UI immediately hides messages after `expireAt`. Firestore TTL provides server-side cleanup.

## Remote backend switch

Build with:

```bash
flutter build apk --dart-define=USE_FIREBASE_CHAT=true
```

Without this flag, the application intentionally uses the in-memory demo repository.

## Retention choices

- Default: 2 days
- 1 week
- 2 weeks
- 3 weeks

The client writes the absolute UTC timestamp to `expireAt`; users cannot choose arbitrary retention values from the UI.
