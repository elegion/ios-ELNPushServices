//
//  NotificationTests.m
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 01.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ELNAPSNotification.h"

static NSDictionary *ELNJSONObjectFromResource(NSString *name);

@interface NotificationTests : XCTestCase

@end

@implementation NotificationTests

- (void)testSimplePayloadWithAlertTitleAsString {
    NSDictionary *payload = ELNJSONObjectFromResource(@"AlertWithStringAsTitle");
    ELNAPSNotification *notification = [[ELNAPSNotification alloc] initWithDictionary:payload];
    XCTAssertEqualObjects(notification.alert.title, @"Message received from Bob");
    XCTAssertNotNil(notification.userInfo[@"acme2"]);
}

- (void)testPayloadWithBadgeAndLocalizedActionKey {
    NSDictionary *payload = ELNJSONObjectFromResource(@"AlertWithBadgeAndLocalizedActionKey");
    ELNAPSNotification *notification = [[ELNAPSNotification alloc] initWithDictionary:payload];
    XCTAssertEqualObjects(notification.alert.title, @"Game Request");
    XCTAssertEqualObjects(notification.alert.body, @"Bob wants to play poker");
    XCTAssertEqualObjects(notification.badge, @5);
    XCTAssertEqualObjects(notification.userInfo[@"acme1"], @"bar");
}


@end

static NSDictionary *ELNJSONObjectFromResource(NSString *name) {
    NSString *path = [[NSBundle bundleForClass:NotificationTests.class] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)0 error:nil];
}
