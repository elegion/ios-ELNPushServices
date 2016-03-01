//
//  ELNAPSManager.h
//  e-legion
//
//  Created by Nesterenko Dmitry on 16.06.15.
//  Copyright (c) 2015 E-Legion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELNAPSNotificationHandler.h"
#import "ELNAPSManagerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// Notification may be triggered any time the device token changes, not just in response to your app registering or re-registering
FOUNDATION_EXPORT NSString * const ELNAPSManagerDidReceiveDeviceTokenForRemoteNotifications;
FOUNDATION_EXPORT NSString * const ELNAPSManagerDidFailToRegisterForRemoteNotifications;
FOUNDATION_EXPORT NSString * const ELNAPSManagerDidReceiveRemoteNotification;

/// Apple Push Services Manager
///
/// By default it is being initialized with [.Alert, .Badge, .Sound] types. Use `initWithType:` method to specify exact remote notification types
@interface ELNAPSManager : NSObject

@property (nonatomic, weak) id<ELNAPSManagerDelegate> delegate;

- (instancetype)initWithType:(UIRemoteNotificationType)types NS_DESIGNATED_INITIALIZER;

/// Registers current application for remote notification types. iOS7 compatible.
- (void)registerForRemoteNotifications;

/// Unregisters current application from remote notification types.
- (void)unregisterForRemoteNotifications;

/// Should be called from AppDelegate's `application:didRegisterForRemoteNotificationsWithDeviceToken:` method.
///
/// Throws `ELNAPSManagerDidReceiveDeviceTokenForRemoteNotifications` notification.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

/// Should be called from AppDelegate's `application:didFailToRegisterForRemoteNotificationsWithError:` method.
///
/// Throws `ELNAPSManagerDidFailToRegisterForRemoteNotifications` notification.
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

/// Should be called from AppDelegate's `application:didReceiveRemoteNotification:` method.
///
/// Throws `ELNAPSManagerDidReceiveRemoteNotification` notification.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

/// Should be called from AppDelegate's `application:didReceiveRemoteNotification:fetchCompletionHandler:` method.
///
/// Throws `ELNAPSManagerDidReceiveRemoteNotification` notification.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^ _Nullable)(UIBackgroundFetchResult result))handler;

- (void)registerNotificationHandler:(id<ELNAPSNotificationHandler>)handler;
- (void)unregisterAllNotificationHandlers;

@end

NS_ASSUME_NONNULL_END
