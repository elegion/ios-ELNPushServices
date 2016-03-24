//
//  ELNAPSNotificationHandler.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNAPSNotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ELNAPSNotificationHandler <NSObject>

@required
- (BOOL)shouldHandleNotification:(ELNAPSNotification *)notification forApplication:(UIApplication *)application;

- (UIBackgroundFetchResult)handleNotification:(ELNAPSNotification *)notification forApplication:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
