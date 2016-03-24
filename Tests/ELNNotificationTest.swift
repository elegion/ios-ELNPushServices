//
//  ELNNotificationTest.swift
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 24.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import XCTest

class ELNNotificationTest: XCTestCase {

    func testSimplePayloadWithAlertTitleAsString() {
        let payload = try! JSONObjectFromResource("AlertWithStringAsTitle")
        let notification = ELNAPSNotification(dictionary: payload!)
        XCTAssertEqual(notification.alert!.title, "Message received from Bob")
    }

    func testPayloadWithBadgeAndLocalizedActionKey() {
        let payload = try! JSONObjectFromResource("AlertWithBadgeAndLocalizedActionKey")
        let notification = ELNAPSNotification(dictionary: payload!)
        XCTAssertEqual(notification.alert!.title, "Game Request")
        XCTAssertEqual(notification.alert!.body, "Bob wants to play poker")
        XCTAssertEqual(notification.badge, 5)
        XCTAssertEqual(notification.userInfo!["acme1"] as? String, "bar")
    }

}

private func JSONObjectFromResource(name: String) throws -> [NSObject : AnyObject]? {
    let bundle = NSBundle(forClass: ELNNotificationTest.self)
    
    guard
        let path = bundle.pathForResource(name, ofType: "json"),
        let data = NSData(contentsOfFile: path) else {
        return nil
    }
    
    return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [NSObject : AnyObject]
}