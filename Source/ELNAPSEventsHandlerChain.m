//
//  ELNAPSEventsHandlerChain.m
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 24.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import "ELNAPSEventsHandlerChain.h"

@interface ELNAPSEventsHandlerChain ()

@property (nonatomic, strong) NSMutableArray<id<ELNAPSNotificationHandler>> *notificationHandlers;

@end

@implementation ELNAPSEventsHandlerChain

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.notificationHandlers = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Notification Handlers

- (void)addNotificationHandler:(id<ELNAPSNotificationHandler>)handler {
    [self.notificationHandlers addObject:handler];
}

- (void)removeNotificationHandler:(id<ELNAPSNotificationHandler>)handler {
    [self.notificationHandlers removeObject:handler];
}

#pragma mark - Delegate Callbacks

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // do nothing
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // do nothing
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result) {
        // do nothing
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    ELNAPSNotification *notification = [[ELNAPSNotification alloc] initWithDictionary:userInfo];
    
    UIBackgroundFetchResult result = UIBackgroundFetchResultNoData;
    for (id<ELNAPSNotificationHandler> object in self.notificationHandlers) {
        if ([object shouldHandleNotification:notification forApplication:application]) {
            result = [object handleNotification:notification forApplication:application];
            break;
        }
    }
    
    if (handler) {
        handler(result);
    }
}

@end
