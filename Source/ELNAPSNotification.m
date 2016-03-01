//
//  ELNAPSNotification.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import "ELNAPSNotification.h"

@interface ELNAPSNotification ()

@property (nonatomic, strong) ELNAPSNotificationAlert *alert;
@property (nonatomic, strong) NSNumber *badge;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) NSNumber *contentAvailable;
@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation ELNAPSNotification

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithDictionary:@{}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        id aps = dictionary[@"aps"];
        if ([aps isKindOfClass:[NSDictionary class]]) {
            // alert
            id alert = [(NSDictionary *)aps valueForKey:@"alert"];
            if ([alert isKindOfClass:[NSDictionary class]]) {
                self.alert = [[ELNAPSNotificationAlert alloc] initWithDictionary:alert];
            } else if ([alert isKindOfClass:[NSString class]]) {
                self.alert = [[ELNAPSNotificationAlert alloc] initWithTitle:alert];
            }
            
            // badge
            id badge = [(NSDictionary *)aps valueForKey:@"badge"];
            if ([badge isKindOfClass:[NSString class]]) {
                NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
                badge = [numberFormatter numberFromString:badge];
            }
            if ([badge isKindOfClass:[NSNumber class]])
                self.badge = badge;
            
            // sound
            id sound = [(NSDictionary *)aps valueForKey:@"sound"];
            if ([sound isKindOfClass:[NSString class]])
                self.sound = sound;
            
            // contentAvailable
            id contentAvailable = [(NSDictionary *)aps valueForKey:@"content-available"];
            if ([contentAvailable isKindOfClass:[NSString class]]) {
                NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
                contentAvailable = [numberFormatter numberFromString:badge];
            }
            if ([contentAvailable isKindOfClass:[NSNumber class]])
                self.contentAvailable = contentAvailable;
        }
        
        // user info
        NSMutableDictionary *userInfo = [dictionary mutableCopy];
        [userInfo removeObjectForKey:@"aps"];
        if (userInfo.count > 0)
            self.userInfo = [userInfo copy];
    }
    return self;
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    typeof(self) copy = [self.class new];
    copy.alert = self.alert;
    copy.badge = self.badge;
    copy.sound = self.sound;
    copy.contentAvailable = self.contentAvailable;
    copy.userInfo = self.userInfo;
    return copy;
}

#pragma mark - Describing Objects

- (NSString *)description {
    NSMutableArray *properties = [NSMutableArray new];
    for (NSString *selector in @[NSStringFromSelector(@selector(alert)), NSStringFromSelector(@selector(badge)), NSStringFromSelector(@selector(sound)), NSStringFromSelector(@selector(contentAvailable)), NSStringFromSelector(@selector(userInfo))]) {
        [properties addObject:[NSString stringWithFormat:@"%@ = %@", selector, [self valueForKey:selector]]];
    }
    return [NSString stringWithFormat:@"<%@: %p %@>", NSStringFromClass(self.class), self, properties];
}

@end
