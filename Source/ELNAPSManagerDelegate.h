//
//  ELNAPSManagerDelegate.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 24.12.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELNAPSManager;

@protocol ELNAPSManagerDelegate <NSObject>

- (void)APSManager:(ELNAPSManager *)APSManager didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)APSManager:(ELNAPSManager *)APSManager didRegisterForRemoteNotificationsWithError:(NSError *)error;

@end
