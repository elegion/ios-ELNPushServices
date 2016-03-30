//
//  ELNAPSManager.m
//  e-legion
//
//  Created by Nesterenko Dmitry on 16.06.15.
//  Copyright (c) 2015 E-Legion. All rights reserved.
//

#import "ELNAPSManager.h"
#import "ELNAPSNotificationHandler.h"
#import "ELNAPSEventsHandlerChain.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
static UIUserNotificationType ELNUserNotificationTypeFromRemoteNotificationType(UIRemoteNotificationType type) {
    if (type == UIRemoteNotificationTypeNone)
        return UIUserNotificationTypeNone;
    
    UIUserNotificationType result = UIUserNotificationTypeNone;
    if ((type & UIRemoteNotificationTypeBadge) == UIRemoteNotificationTypeBadge) {
        result |= UIUserNotificationTypeBadge;
    }
    if ((type & UIRemoteNotificationTypeSound) == UIRemoteNotificationTypeSound) {
        result |= UIUserNotificationTypeSound;
    }
    if ((type & UIRemoteNotificationTypeAlert) == UIRemoteNotificationTypeAlert) {
        result |= UIUserNotificationTypeAlert;
    }
    
    return result;
}
#endif

@interface ELNAPSManager ()

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
@property (nonatomic, assign) UIUserNotificationType type;
#else
@property (nonatomic, assign) UIRemoteNotificationType type;
#endif

@end

@implementation ELNAPSManager

#pragma mark - Initialization

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0

- (instancetype)init {
    return [self initWithType:(UIUserNotificationType)(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound)];
}

- (instancetype)initWithType:(UIUserNotificationType)type {
    self = [super init];
    if (self) {
        self.type = type;
        self.eventsHandler = [ELNAPSEventsHandlerChain new];
    }
    return self;
}

#else

- (instancetype)init {
    return [self initWithType:(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

- (instancetype)initWithType:(UIRemoteNotificationType)type {
    self = [super init];
    if (self) {
        self.type = type;
        self.eventsHandler = [ELNAPSEventsHandlerChain new];
    }
    return self;
}

#endif

#pragma mark - Registering and Unregistering

- (void)registerForRemoteNotificationsWithApplication:(UIApplication *)application {
    application = application ?: [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
        UIUserNotificationType type = ELNUserNotificationTypeFromRemoteNotificationType(self.type);
#else 
        UIUserNotificationType type = self.type;
#endif
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
#pragma clang diagnostic pop
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
        [application registerForRemoteNotificationTypes:self.type];
#endif
    }
}

- (void)unregisterForRemoteNotificationsWithApplication:(UIApplication *)application {
    application = application ?: [UIApplication sharedApplication];
    [application unregisterForRemoteNotifications];
}

@end
