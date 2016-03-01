//
//  ELNAPSNotification.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNAPSNotificationAlert.h"

NS_ASSUME_NONNULL_BEGIN

/// Notification Payload Object
///
/// @see https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ApplePushService.html#//apple_ref/doc/uid/TP40008194-CH100-SW1
@interface ELNAPSNotification : NSObject <NSCopying>

/// If this property is included, the system displays a standard alert.
/// You may specify a string as the value of alert or a dictionary as its value.
/// If you specify a string, it becomes the message text of an alert with two buttons: Close and View. If the user taps View, the app is launched.
///
/// Alternatively, you can specify a dictionary as the value of alert.
///
/// If you want the device to display the message text as-is in an alert that has both the Close and View buttons, then specify a string as the direct value of alert. Don’t specify a dictionary as the value of alert if the dictionary only has the body property.
@property (nonatomic, strong, readonly, nullable) ELNAPSNotificationAlert *alert;

/// The number to display as the badge of the app icon.
///
/// If this property is absent, the badge is not changed. To remove the badge, set the value of this property to 0.
@property (nonatomic, strong, readonly, nullable) NSNumber *badge;

/// The name of a sound file in the app bundle. The sound in this file is played as an alert. If the sound file doesn’t exist or default is specified as the value, the default alert sound is played. The audio must be in one of the audio data formats that are compatible with system sounds
@property (nonatomic, strong, readonly, nullable) NSString *sound;

/// Provide this key with a value of 1 to indicate that new content is available. Including this key and value means that when your app is launched in the background or resumed, application:didReceiveRemoteNotification:fetchCompletionHandler: is called.
@property (nonatomic, strong, readonly, nullable) NSNumber *contentAvailable;

/// Provide this key with a string value that represents the identifier property of the UIMutableUserNotificationCategory object you created to define custom actions. To learn more about using custom actions, see Registering Your Actionable Notification Types.
@property (nonatomic, strong, readonly, nullable) NSString *category;

@property (nonatomic, strong, readonly, nullable) NSDictionary *userInfo;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
