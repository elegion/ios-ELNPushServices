//
//  ELNAPSNotificationAlert.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 16/06/15.
//  Copyright © 2015 E-Legion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELNAPSNotificationAlert : NSObject <NSCopying>

/// A short string describing the purpose of the notification. Apple Watch displays this string as part of the notification interface. This string is displayed only briefly and should be crafted so that it can be understood quickly. This key was added in iOS 8.2.
@property (nonatomic, copy, readonly, nullable) NSString *title;

/// The text of the alert message.
@property (nonatomic, copy, readonly, nullable) NSString *body;

/// The key to a title string in the Localizable.strings file for the current localization. The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the title-loc-args array. See Localized Formatted Strings for more information. This key was added in iOS 8.2.
@property (nonatomic, copy, readonly, nullable) NSString *titleLocKey;

/// Variable string values to appear in place of the format specifiers in title-loc-key. See Localized Formatted Strings for more information. This key was added in iOS 8.2.
@property (nonatomic, copy, readonly, nullable) NSArray *titleLocArgs;

/// If a string is specified, the system displays an alert that includes the Close and View buttons. The string is used as a key to get a localized string in the current localization to use for the right button’s title instead of “View”. See Localized Formatted Strings for more information.
@property (nonatomic, copy, readonly, nullable) NSString *actionLocKey;

/// A key to an alert-message string in a Localizable.strings file for the current localization (which is set by the user’s language preference). The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the loc-args array. See Localized Formatted Strings for more information.
@property (nonatomic, copy, readonly, nullable) NSString *locKey;

/// Variable string values to appear in place of the format specifiers in loc-key. See Localized Formatted Strings for more information.
@property (nonatomic, copy, readonly, nullable) NSArray *locArgs;

/// The filename of an image file in the app bundle; it may include the extension or omit it. The image is used as the launch image when users tap the action button or move the action slider. If this property is not specified, the system either uses the previous snapshot,uses the image identified by the UILaunchImageFile key in the app’s Info.plist file, or falls back to Default.png.
@property (nonatomic, copy, readonly, nullable) NSString *launchImage;

@property (nonatomic, copy, readonly, nullable) NSArray *actions;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

/// Initializes notification alert with title.
- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

/// Initializes notification alert using alert payload dictionary.
- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

/// Returns localized title using `loc-key` and `title-loc-key` payload keys.
- (NSString *)localizedTitle;

- (NSString *)localizedTitleFromTable:(NSString * _Nullable)tbl;

@end

NS_ASSUME_NONNULL_END
