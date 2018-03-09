# FALanguage

[![CI Status](http://img.shields.io/travis/fadizant/FALanguage.svg?style=flat)](https://travis-ci.org/fadizant/FALanguage)
[![Version](https://img.shields.io/cocoapods/v/FALanguage.svg?style=flat)](http://cocoapods.org/pods/FALanguage)
[![License](https://img.shields.io/cocoapods/l/FALanguage.svg?style=flat)](http://cocoapods.org/pods/FALanguage)
[![Platform](https://img.shields.io/cocoapods/p/FALanguage.svg?style=flat)](http://cocoapods.org/pods/FALanguage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How to use

### ObjC
```ruby
// en = language code
[NSBundle setLanguage:@"en"];

//you need to reload window.rootViewController
AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
appDelegate.window.rootViewController = [self.storyboard instantiateInitialViewController];
[appDelegate.window makeKeyAndVisible];
```

### Swift4
```ruby
// en = language code
Bundle.setLanguage("en")

//you need to reload window.rootViewController
let appDelegate = UIApplication.shared.delegate
appDelegate?.window??.rootViewController = self.storyboard?.instantiateInitialViewController()
appDelegate?.window??.makeKeyAndVisible()
```

## Requirements

iOS 9.0+

## Installation

FALanguage is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FALanguage"
```

## Author

fadizant, fadizant@hotmail.com

## License

FALanguage is available under the MIT license. See the LICENSE file for more info.

