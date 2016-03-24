//
//  ELNAPSEventsHandlerChain.h
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 24.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNAPSEventsHandler.h"
#import "ELNAPSNotificationHandler.h"

@interface ELNAPSEventsHandlerChain : NSObject <ELNAPSEventsHandler>

- (void)addNotificationHandler:(id<ELNAPSNotificationHandler>)handler;

- (void)removeNotificationHandler:(id<ELNAPSNotificationHandler>)handler;

@end
