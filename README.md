# nhl_app

## Setup

Requires Flutter with Dart SDK `^3.13.5`.

1. Install dependencies:

   ```sh
   flutter pub get
   ```

2. Generate code (Riverpod, Retrofit, Freezed, json_serializable):

   ```sh
   dart run build_runner build -d
   ```

   Use `watch` instead of `build` to regenerate on save.

3. Create a `.env` file in the project root (it is gitignored):

   ```
   WEB_API_URL=<api base url>
   ```

## Run

```sh
flutter run --dart-define-from-file=.env
```

## Test

```sh
flutter test
```
