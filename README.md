# DIAnalytics

[![Version](https://img.shields.io/cocoapods/v/DIAnalytics.svg?style=flat)](http://cocoapods.org/pods/DIAnalytics)
[![License](https://img.shields.io/cocoapods/l/DIAnalytics.svg?style=flat)](http://cocoapods.org/pods/DIAnalytics)
[![Platform](https://img.shields.io/cocoapods/p/DIAnalytics.svg?style=flat)](http://cocoapods.org/pods/DIAnalytics)

## Requirements

- Firebase project and his "GoogleService-Info.plist". For more information, refer to [Firebase Cloud Messaging docs][1]
- Application Id provided by Dialog Insight

## Installation

DIAnalytics is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DIAnalytics"
```

## Usage

1. Add your "GoogleService-Info.plist" provided by Firebase to the root of your project. Ensure that the file is in the "Copy Bundle Resources" of your target project.  

2. Add folling code to your AppDelegate:

```objective-c
#pragma mark - Notification delegate

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [DIAnalytics handleDidReceiveRemoteNotification:userInfo];

    if (application.applicationState == UIApplicationStateActive ) {
        NSLog(@"Application is in foreground when receive notificaiton, application should handle display of notification.");
    }
}

//For iOS under 10, you must implement this two methode to registe for token
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [DIAnalytics handleDidRegisterForRemoteNotificationWithDeviceToken:deviceToken];
}

```

3. Setup your preferance.
```objective-c
[DIAnalytics setLogEnabled:YES];
[DIAnalytics setBaseUrl:@"https://MY_URL.com"];
```

4. Start library with your ApplicationId provided by Dialog Insight in your "didFinishLaunchingWithOptions" implementation.

```objective-c
[DIAnalytics startWithApplicationId:@"MY_APPLICATION_ID_PROVIDED_BY_DIALOG_INSIGHT" withLaunchOptions:launchOptions];
```

5. Send information about the user.
```objective-c
NSMutableDictionary *customFieldsDictionary = [[NSMutableDictionary alloc] init];
[customFieldsDictionary setObject:self.emailTextField.text forKey:@"f_EMail"];
[customFieldsDictionary setObject:self.firstNameTextField.text forKey:@"first_name"];
[customFieldsDictionary setObject:self.nameTextField.text forKey:@"name"];
NSDictionary *contactDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:customFieldsDictionary, @"contact", nil];

[DIAnalytics identify:contactDictionary];
```

6. Registe for push notification. This will prompt to user an UIAlertView asking to authorize notifications.
```objective-c
[DIAnalytics registeForRemoteNotification];
```

## Authors

Dialog Insight, info@dialoginsight.com

## License

[1]: https://firebase.google.com/docs/cloud-messaging/
