//
//  ELNAPSNotification.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import "ELNAPSNotification.h"

@implementation ELNAPSNotification

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        NSDictionary *aps = dictionary[@"aps"];
        if ([aps isKindOfClass:[NSDictionary class]]) {
            // alert
            id alert = [aps valueForKey:@"alert"];
            if ([alert isKindOfClass:[NSDictionary class]]) {
                self.alert = [[ELNAPSNotificationAlert alloc] initWithDictionary:alert];
            } else if ([alert isKindOfClass:[NSString class]]) {
                self.alert = [[ELNAPSNotificationAlert alloc] initWithTitle:alert];
            }
            
            NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
            
            // badge
            id badge = [aps valueForKey:@"badge"];
            if ([badge isKindOfClass:[NSString class]]) {
                badge = [numberFormatter numberFromString:badge];
            }
            if ([badge isKindOfClass:[NSNumber class]]) {
                self.badge = badge;
            }
            
            // sound
            id sound = [aps valueForKey:@"sound"];
            if ([sound isKindOfClass:[NSString class]]) {
                self.sound = sound;
            }
            
            // contentAvailable
            id contentAvailable = [aps valueForKey:@"content-available"];
            if ([contentAvailable isKindOfClass:[NSString class]]) {
                contentAvailable = [numberFormatter numberFromString:badge];
            }
            if ([contentAvailable isKindOfClass:[NSNumber class]]) {
                self.contentAvailable = contentAvailable;
            }
            
            // category
            id category = [aps valueForKey:@"category"];
            if ([category isKindOfClass:[NSString class]]) {
                self.category = badge;
            }
        }
        
        // user info
        NSMutableDictionary *userInfo = [dictionary mutableCopy];
        [userInfo removeObjectForKey:@"aps"];
        if (userInfo.count > 0) {
            self.userInfo = [userInfo copy];
        }
    }
    return self;
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    __typeof__(self) copy = [self.class new];
    copy.alert = self.alert;
    copy.badge = self.badge;
    copy.sound = self.sound;
    copy.contentAvailable = self.contentAvailable;
    copy.category = self.category;
    copy.userInfo = self.userInfo;
    return copy;
}

#pragma mark - Describing Objects

- (NSString *)description {
    NSMutableArray *properties = [NSMutableArray new];
    for (NSString *selector in @[NSStringFromSelector(@selector(alert)), NSStringFromSelector(@selector(badge)), NSStringFromSelector(@selector(sound)), NSStringFromSelector(@selector(contentAvailable)), NSStringFromSelector(@selector(category)), NSStringFromSelector(@selector(userInfo))]) {
        id value = [self valueForKey:selector];
        if (value != nil) {
            [properties addObject:[NSString stringWithFormat:@"%@ = %@", selector, value]];
        }
    }

    return [NSString stringWithFormat:@"<%@: %p %@>", NSStringFromClass(self.class), (void *)self, properties];
}

@end
