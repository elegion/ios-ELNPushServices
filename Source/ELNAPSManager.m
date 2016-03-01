//
//  ELNAPSManager.m
//  e-legion
//
//  Created by Nesterenko Dmitry on 16.06.15.
//  Copyright (c) 2015 E-Legion. All rights reserved.
//

#import "ELNAPSManager.h"
#import "ELNAPSNotificationHandler.h"

NSString * const ELNAPSManagerDidReceiveDeviceTokenForRemoteNotifications = @"ELNAPSManagerDidReceiveDeviceTokenForRemoteNotifications";
NSString * const ELNAPSManagerDidFailToRegisterForRemoteNotifications = @"ELNAPSManagerDidFailToRegisterForRemoteNotifications";
NSString * const ELNAPSManagerDidReceiveRemoteNotification = @"ELNAPSManagerDidReceiveRemoteNotification";

static UIUserNotificationType ELNUserNotificationTypeFromRemoteNotificationType(UIRemoteNotificationType type) {
    if (type == UIRemoteNotificationTypeNone)
        return UIUserNotificationTypeNone;
    
    UIUserNotificationType result = UIUserNotificationTypeNone;
    if (type & UIRemoteNotificationTypeBadge)
        result |= UIUserNotificationTypeBadge;
    if (type & UIRemoteNotificationTypeSound)
        result |= UIUserNotificationTypeSound;
    if (type & UIRemoteNotificationTypeAlert)
        result |= UIUserNotificationTypeAlert;
    
    return result;
}

@interface ELNAPSManager ()

@property (nonatomic, assign) UIRemoteNotificationType type;
@property (nonatomic, strong) NSMutableArray<id<ELNAPSNotificationHandler>> *notificationHandlers;

@end

@implementation ELNAPSManager

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithType:(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

- (instancetype)initWithType:(UIRemoteNotificationType)type {
    self = [super init];
    if (self) {
        self.notificationHandlers = [NSMutableArray new];
        self.type = type;
    }
    return self;
}

#pragma mark - Registering and Unregistering

- (void)registerRemoteNotificationsForApplication:(UIApplication *)application {
    application = application ?: [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = ELNUserNotificationTypeFromRemoteNotificationType(self.type);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:self.type];
    }
}

- (void)unregisterRemoteNotificationsForApplication:(UIApplication *)application {
    application = application ?: [UIApplication sharedApplication];
    [application unregisterForRemoteNotifications];
}

#pragma mark - Delegate Callbacks

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[NSNotificationCenter defaultCenter] postNotificationName:ELNAPSManagerDidReceiveDeviceTokenForRemoteNotifications object:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[NSNotificationCenter defaultCenter] postNotificationName:ELNAPSManagerDidFailToRegisterForRemoteNotifications object:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    ELNAPSNotification *notification = [[ELNAPSNotification alloc] initWithDictionary:userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ELNAPSManagerDidReceiveRemoteNotification object:notification];
    
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

#pragma mark - Notification Handlers

- (void)registerNotificationHandler:(id<ELNAPSNotificationHandler>)handler {
    [self.notificationHandlers addObject:handler];
}

- (void)unregisterAllNotificationHandlers {
    [self.notificationHandlers removeAllObjects];
}

@end
