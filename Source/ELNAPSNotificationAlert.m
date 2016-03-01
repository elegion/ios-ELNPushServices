//
//  ELNAPSNotificationAlert.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import "ELNAPSNotificationAlert.h"

@interface ELNAPSNotificationAlert ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *titleLocKey;
@property (nonatomic, copy) NSArray *titleLocArgs;
@property (nonatomic, copy) NSString *actionLocKey;
@property (nonatomic, copy) NSString *locKey;
@property (nonatomic, copy) NSArray *locArgs;
@property (nonatomic, copy) NSString *launchImage;
@property (nonatomic, copy) NSArray *actions;

@end

@implementation ELNAPSNotificationAlert

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        // do nothing
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
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

        // actions
        id actions = [dictionary valueForKey:@"actions"];
        if ([actions isKindOfClass:[NSArray class]]) {
            self.actions = actions;
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
    copy.actions = self.actions;
    return copy;
}

#pragma mark - Localized Title

- (NSString *)localizedTitle {
    return [self localizedTitleFromTable:nil];
}

- (NSString *)localizedTitleFromTable:(NSString *)tbl {
    NSString *key = self.locKey;
    NSArray *args = self.locArgs ?: @[];
    if (key == nil) {
        key = self.titleLocKey;
        args = self.titleLocArgs ?: @[];
    }
    
    id format = NSLocalizedStringFromTable(key, tbl, nil);
    void *argList = malloc(sizeof(NSString *) * args.count);
    [args getObjects:(__unsafe_unretained id *)argList];
    
    NSString *title = [[NSString alloc] initWithFormat:format arguments:argList];
    free(argList);
    
    return title;
}

#pragma mark - Describing Objects

- (NSString *)description {
    NSMutableArray *properties = [NSMutableArray new];
    for (NSString *selector in @[NSStringFromSelector(@selector(title)), NSStringFromSelector(@selector(body)), NSStringFromSelector(@selector(titleLocKey)), NSStringFromSelector(@selector(titleLocArgs)), NSStringFromSelector(@selector(actionLocKey)), NSStringFromSelector(@selector(locKey)), NSStringFromSelector(@selector(locArgs)), NSStringFromSelector(@selector(launchImage)), NSStringFromSelector(@selector(actions))]) {
        [properties addObject:[NSString stringWithFormat:@"%@ = %@", selector, [self valueForKey:selector]]];
    }

    return [NSString stringWithFormat:@"<%@: %p %@>", NSStringFromClass(self.class), self, properties];
}

@end
