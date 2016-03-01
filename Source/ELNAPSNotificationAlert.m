//
//  ELNAPSNotificationAlert.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import "ELNAPSNotificationAlert.h"

@implementation ELNAPSNotificationAlert

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title {
    self = [self init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        // title
        id title = [dictionary valueForKey:@"title"];
        if ([title isKindOfClass:[NSString class]]) {
            self.title = title;
        }
        
        // body
        id body = [dictionary valueForKey:@"body"];
        if ([body isKindOfClass:[NSString class]]) {
            self.body = body;
        }

        // title loc key
        id titleLocKey = [dictionary valueForKey:@"title-loc-key"];
        if ([titleLocKey isKindOfClass:[NSString class]]) {
            self.titleLocKey = titleLocKey;
        }

        // title loc args
        id titleLocArgs = [dictionary valueForKey:@"title-loc-args"];
        if ([titleLocArgs isKindOfClass:[NSArray class]]) {
            self.titleLocArgs = titleLocArgs;
        }

        // action loc key
        id actionLocKey = [dictionary valueForKey:@"action-loc-key"];
        if ([actionLocKey isKindOfClass:[NSString class]]) {
            self.actionLocKey = actionLocKey;
        }
        
        // loc key
        id locKey = [dictionary valueForKey:@"loc-key"];
        if ([locKey isKindOfClass:[NSString class]]) {
            self.locKey = locKey;
        }
        
        // loc args
        id locArgs = [dictionary valueForKey:@"loc-args"];
        if ([locArgs isKindOfClass:[NSArray class]]) {
            self.locArgs = locArgs;
        }
        
        // launch image
        id launchImage = [dictionary valueForKey:@"launch-image"];
        if ([launchImage isKindOfClass:[NSString class]]) {
            self.launchImage = launchImage;
        }
    }
    return self;
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    typeof(self) copy = [self.class new];
    copy.title = self.title;
    copy.body = self.body;
    copy.titleLocKey = self.titleLocKey;
    copy.titleLocArgs = self.titleLocArgs;
    copy.actionLocKey = self.actionLocKey;
    copy.locKey = self.locKey;
    copy.locArgs = self.locArgs;
    copy.launchImage = self.launchImage;
    return copy;
}

#pragma mark - Localized Title

- (NSString *)localizedTitle {
    NSString *key = self.locKey;
    NSArray *args = self.locArgs ?: @[];
    if (key == nil) {
        key = self.titleLocKey;
        args = self.titleLocArgs ?: @[];
    }
    
    id format = NSLocalizedString(key, nil);
    void *argList = malloc(sizeof(NSString *) * args.count);
    [args getObjects:(__unsafe_unretained id *)argList];
    
    NSString *title = [[NSString alloc] initWithFormat:format arguments:argList];
    free(argList);
    
    return title;
}

#pragma mark - Describing Objects

- (NSString *)description {
    NSMutableArray *properties = [NSMutableArray new];
    for (NSString *selector in @[NSStringFromSelector(@selector(title)), NSStringFromSelector(@selector(body)), NSStringFromSelector(@selector(titleLocKey)), NSStringFromSelector(@selector(titleLocArgs)), NSStringFromSelector(@selector(actionLocKey)), NSStringFromSelector(@selector(locKey)), NSStringFromSelector(@selector(locArgs)), NSStringFromSelector(@selector(launchImage))]) {
        id value = [self valueForKey:selector];
        if (value != nil) {
            [properties addObject:[NSString stringWithFormat:@"%@ = %@", selector, value]];
        }
    }

    return [NSString stringWithFormat:@"<%@: %p %@>", NSStringFromClass(self.class), self, properties];
}

@end
