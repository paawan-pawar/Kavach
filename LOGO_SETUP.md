# KAVACH Logo Setup Instructions

## Step 1: Save the Logo Image
The KAVACH logo image that was provided needs to be saved to your project:

**Path:** `assets/images/kavach_logo.png`

**How to save it:**
1. Right-click the logo image you provided
2. Select "Save image as..."
3. Navigate to: `c:\Users\LENOVO\OneDrive\Desktop\kavach\assets\images\`
4. Save it as: `kavach_logo.png`

## Step 2: Verify the Files
After saving, you should have:
- `assets/images/kavach_logo.png` ✓
- `assets/images/` directory created ✓
- `pubspec.yaml` updated with assets section ✓

## Step 3: Use the Logo in Your App
The `KavachLogo` widget is ready to use. Example:

```dart
import 'package:kavach/widgets/kavach_logo.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: KavachLogo(
          size: 250,
        ),
      ),
    );
  }
}
```

## Step 4: Run the App
```bash
flutter pub get
flutter run
```

## Optional: Set as App Icon
To use the logo as your app's icon across all platforms:

1. Install flutter_launcher_icons:
```bash
flutter pub add --dev flutter_launcher_icons
```

2. Add to `pubspec.yaml`:
```yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/images/kavach_logo.png"
  min_sdk_android: 21
```

3. Generate icons:
```bash
dart run flutter_launcher_icons
```

That's it! Your KAVACH logo is now integrated into your Flutter project.
