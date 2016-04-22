//
//  ELNAPSEventsHandlerChain.h
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 24.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNAPSEventsHandler.h"

NS_ASSUME_NONNULL_BEGIN

/// Registers events handlers chain.
///
/// It passes a remote notification to the first <ELNAPSNotificationHandler> object that returns YES to `shouldHandleNotification:forApplication:` message.
///
/// @note Listens for `UIApplicationDidFinishLaunchingNotification` to handle remote notifications as a result of application launch.
@interface ELNAPSEventsHandlerChain : NSObject <ELNAPSEventsHandler>

@property (nonatomic, copy, readonly) NSData *deviceToken;

@end

NS_ASSUME_NONNULL_END
