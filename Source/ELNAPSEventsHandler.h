//
//  ELNAPSEventsHandler.h
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 24.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELNAPSNotificationHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ELNAPSEventsHandler <NSObject>

/// Should be called from AppDelegate's `application:didReceiveRemoteNotification:` method.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

/// Should be called from AppDelegate's `application:didReceiveRemoteNotification:fetchCompletionHandler:` method.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

- (void)addNotificationHandler:(id<ELNAPSNotificationHandler>)handler;

- (void)removeNotificationHandler:(id<ELNAPSNotificationHandler>)handler;

@end

NS_ASSUME_NONNULL_END
