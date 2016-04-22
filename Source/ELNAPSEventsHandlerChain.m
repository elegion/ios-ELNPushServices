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
@property (nonatomic, assign) BOOL observeApplicationDidFinishLaunchingNotification;

@end

@implementation ELNAPSEventsHandlerChain

#pragma mark - Object Lifecycle

- (void)dealloc {
    self.observeApplicationDidFinishLaunchingNotification = NO;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.notificationHandlers = [NSMutableArray new];
        self.observeApplicationDidFinishLaunchingNotification = YES;
    }
    return self;
}

#pragma mark - Notification Handling

- (void)addNotificationHandler:(id<ELNAPSNotificationHandler>)handler {
    [self.notificationHandlers addObject:handler];
}

- (void)removeNotificationHandler:(id<ELNAPSNotificationHandler>)handler {
    [self.notificationHandlers removeObject:handler];
}

- (void)handleRemoteNotification:(NSDictionary *)userInfo forApplication:(UIApplication *)application fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
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

#pragma mark - Application Notifications Observation

- (void)setObserveApplicationDidFinishLaunchingNotification:(BOOL)observeApplicationDidFinishLaunchingNotification {
    if (_observeApplicationDidFinishLaunchingNotification == observeApplicationDidFinishLaunchingNotification) {
        return;
    }
    _observeApplicationDidFinishLaunchingNotification = observeApplicationDidFinishLaunchingNotification;
    
    if (self.observeApplicationDidFinishLaunchingNotification) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSDictionary *dictionary = notification.userInfo[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (dictionary == nil) {
        return;
    }

    UIApplication *application = notification.object;
    [self handleRemoteNotification:dictionary forApplication:application fetchCompletionHandler:^(UIBackgroundFetchResult result) {
        // do nothing
    }];
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
    [self handleRemoteNotification:userInfo forApplication:application fetchCompletionHandler:handler];
}

@end
