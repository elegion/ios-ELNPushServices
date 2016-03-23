//
//  ELNAPSManager.h
//  e-legion
//
//  Created by Nesterenko Dmitry on 16.06.15.
//  Copyright (c) 2015 E-Legion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELNAPSNotificationHandler.h"

NS_ASSUME_NONNULL_BEGIN

/// Apple Push Services Manager
///
/// By default it is being initialized with [.Alert, .Badge, .Sound] types. Use `initWithType:` method to specify exact remote notification types.
@interface ELNAPSManager : NSObject

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
- (instancetype)initWithType:(UIUserNotificationType)types NS_DESIGNATED_INITIALIZER;
#else
- (instancetype)initWithType:(UIRemoteNotificationType)types NS_DESIGNATED_INITIALIZER;
#endif

/// Registers current application for remote notification types. iOS7 compatible.
- (void)registerRemoteNotificationsForApplication:(UIApplication * _Nullable)application;

/// Unregisters current application from remote notification types.
- (void)unregisterRemoteNotificationsForApplication:(UIApplication * _Nullable)application;

/// Should be called from AppDelegate's `application:didReceiveRemoteNotification:` method.
///
/// Throws `ELNAPSManagerDidReceiveRemoteNotification` notification.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

/// Should be called from AppDelegate's `application:didReceiveRemoteNotification:fetchCompletionHandler:` method.
///
/// Throws `ELNAPSManagerDidReceiveRemoteNotification` notification.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^ _Nullable)(UIBackgroundFetchResult result))handler;

- (void)registerNotificationHandler:(id<ELNAPSNotificationHandler>)handler;

- (void)unregisterNotificationHandler:(id<ELNAPSNotificationHandler>)handler;

@end

NS_ASSUME_NONNULL_END
