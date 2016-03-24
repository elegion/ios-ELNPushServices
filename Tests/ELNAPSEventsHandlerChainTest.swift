//
//  ELNAPSEventsHandlerChainTest.swift
//  ELNPushServices
//
//  Created by Dmitry Nesterenko on 24.03.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import XCTest

class TestHandler : NSObject, ELNAPSNotificationHandler {
    
    var handled = false
    
    @objc func shouldHandleNotification(notification: ELNAPSNotification!, forApplication application: UIApplication!) -> Bool {
        return true
    }
    
    @objc func handleNotification(notification: ELNAPSNotification!, forApplication application: UIApplication!) -> UIBackgroundFetchResult {
        handled = true
        return .NoData
    }
    
}

class ELNAPSEventsHandlerChainTest: XCTestCase {

    func testChainEventsHandlerShouldHandleNotificationUntilAppropriateHandlerFound() {
        let eventsHandler = ELNAPSEventsHandlerChain()
        let notificationHandler1 = TestHandler()
        let notificationHandler2 = TestHandler()
        eventsHandler.addNotificationHandler(notificationHandler1)
        eventsHandler.addNotificationHandler(notificationHandler2)
        
        let application = UIApplication.sharedApplication()
        eventsHandler.application(application, didReceiveRemoteNotification: ["alert": ["title": "title"]])
        XCTAssertTrue(notificationHandler1.handled)
        XCTAssertFalse(notificationHandler2.handled)
    }

}
