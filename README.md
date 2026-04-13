# MyvitaleSDKModular

[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.0%2B-blue)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-informational)](https://github.com/MyVitale/ios_sdk_myvitale_modular)

> Intelligent, automatic, comprehensive, adaptive Training & Nutrition System for iOS.

MyvitaleSDKModular is a modular iOS SDK that integrates **training**, **nutrition** and **user health profile** functionality into your app through a unified public interface. It ships as a set of pre-compiled `.xcframework` binaries and is distributed via CocoaPods.

---

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Public API](#public-api)
  - [Initialization](#initialization)
  - [UI Customization](#ui-customization)
  - [Navigation](#navigation)
  - [User Profile](#user-profile)
  - [Delegate](#delegate)
- [Modules](#modules)
- [Architecture Notes](#architecture-notes)
- [Known Limitations](#known-limitations)
- [License](#license)

---

## Requirements

| Requirement | Minimum version |
|-------------|----------------|
| iOS | 13.0 |
| Swift | 5.0 |
| Xcode | 13.0+ |
| CocoaPods | 1.10+ |

> ⚠️ **Simulator support**: `arm64` is excluded from simulator builds. The SDK runs on physical devices and on `x86_64` simulators (Intel Mac). Apple Silicon simulators are not supported.

---

## Installation

### CocoaPods

Add the following to your `Podfile`:

```ruby
pod 'MyvitaleSDKModular', :git => 'https://github.com/MyVitale/ios_sdk_myvitale_modular.git', :branch => 'main'
```

Then run:

```bash
pod install
```

Open the generated `.xcworkspace` file to build your project.

### Podfile recommended settings

To avoid common build issues, add these flags to your target:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
end
```

---

## Getting Started

### 1. Import the SDK

```swift
import VitaleHealthSDK
```

### 2. Configure on app launch

In your `AppDelegate` or `SceneDelegate`, initialize the SDK with your credentials:

```swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    VitaleSDK.shared.startSDKWith(
        appID: "YOUR_APP_ID",
        password: "YOUR_PASSWORD",
        userID: "CURRENT_USER_ID"
    )

    return true
}
```

### 3. Set a delegate (optional)

```swift
VitaleSDK.shared.setDelegate(self)
```

```swift
extension AppDelegate: VitaleSDKDelegate {
    func newEvent(_ eventName: String) {
        print("SDK event received: \(eventName)")
    }
}
```

---

## Configuration

### `startSDKWith(appID:password:userID:url:userCenter:name:lastname:)`

Initializes all internal SDK modules. Must be called before any `show*` method.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `appID` | `String` | ✅ | Application identifier provided by MyVitale |
| `password` | `String` | ✅ | Authentication secret |
| `userID` | `String` | ✅ | Unique identifier for the current user |
| `url` | `String?` | ❌ | Custom API base URL (uses default if `nil`) |
| `userCenter` | `String?` | ❌ | Center/clinic identifier for multi-center setups |
| `name` | `String?` | ❌ | User's first name — pre-populates the profile on first launch |
| `lastname` | `String?` | ❌ | User's last name — pre-populates the profile on first launch |

---

## Public API

### Initialization

```swift
VitaleSDK.shared.startSDKWith(
    appID: "app_id",
    password: "secret",
    userID: "user_123",
    url: "https://custom.api.endpoint",   // optional
    userCenter: "center_456"              // optional
)
```

### User Center

Override the user center after initialization:

```swift
VitaleSDK.shared.setUserCenter("center_789")
```

---

### UI Customization

All customization methods should be called after `startSDKWith` and before presenting any SDK screen.

```swift
// Primary accent color (hex string)
VitaleSDK.shared.setMainColor(color: "#FF5722")

// Primary button color
VitaleSDK.shared.setPrimaryButtonColor("#FF5722")

// Navigation bar background color
VitaleSDK.shared.setNavigationBarColor(color: "#FFFFFF")

// Navigation bar tint color (back buttons, icons)
VitaleSDK.shared.setNavigationTintColor(color: "#000000")

// Small logo shown inside SDK screens
VitaleSDK.shared.setSmallLogo(UIImage(named: "my_logo"))

// Nutrition content country (integer country code)
VitaleSDK.shared.setNutritionCountry(country: 34) // Spain
```

> Colors must be provided as **hex strings** (e.g., `"#FF5722"` or `"FF5722"`).

---

### Navigation

All `show*` methods automatically check whether the user has accepted the required terms and conditions. If not, the SDK presents the terms screen before proceeding.

#### Full SDK dashboard

```swift
VitaleSDK.shared.showVitale()
```

#### Nutrition module

```swift
VitaleSDK.shared.showNutrition()
```

#### Training module (full)

```swift
VitaleSDK.shared.showTraining()
```

#### Today's workout

```swift
VitaleSDK.shared.showTodaytraining()
```

#### Exercise library

```swift
VitaleSDK.shared.showLibrary()
```

#### Personal trainer workouts

```swift
VitaleSDK.shared.showPersonalTrainer()
```

#### Custom workouts

```swift
VitaleSDK.shared.showCustomWorkouts()
```

#### Time-based workouts

```swift
VitaleSDK.shared.showTimeBasedWorkouts()
```

#### User profile

```swift
VitaleSDK.shared.showProfile()
```

#### Settings

```swift
VitaleSDK.shared.showSettings()
```

---

### User Profile

#### Update profile data

You can pre-populate or update the user's personal profile programmatically. All parameters are optional:

```swift
VitaleSDK.shared.updatePersonalProfile(
    firstName: "John",
    lastName: "Doe",
    gender: .male,
    height: 180,           // centimeters
    weight: 75.5,          // kilograms
    birthDate: Date()
)
```

#### Fetch profile

Retrieve the current user profile asynchronously:

```swift
VitaleSDK.shared.getProfile { userProfile in
    guard let profile = userProfile else { return }
    print(profile)
}
```

#### Set pathologies

Inform the SDK of the user's active pathologies to adapt training and nutrition recommendations:

```swift
VitaleSDK.shared.setPathologies([.hypertension, .diabetes])
```

---

### Delegate

Implement `VitaleSDKDelegate` to receive analytics events triggered from within the SDK:

```swift
public protocol VitaleSDKDelegate: AnyObject {
    func newEvent(_ eventName: String)
}
```

The delegate reference is `weak` — make sure the object conforming to the protocol is retained elsewhere.

---

## License

MyvitaleSDKModular is available under the **MIT** license. See the [LICENSE](LICENSE) file for more details.

© MyVitale — [www.myvitale.com](https://www.myvitale.com/) · [miguel.munoz@myvitale.com](mailto:miguel.munoz@myvitale.com)