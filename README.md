# ELNPushServices

Упрощает работу с [Apple Push Services](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ApplePushService.html)

- iOS7-совместимая подписка на пуши
- отписка от пушей
- обработка входящих пушей

## Installation

###Cocoapods

```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/elegion/ios-podspecs'

pod 'ELNPushServices' 
```

###Carthage

```
github 'elegion/ios-ELNPushServices'
```

## Usage 

###Register For Remote Notifications

```objective-c
ELNAPSManager *manager = [ELNAPSManager new];

// register for remote notifications in iOS7 compatible way
[manager registerForRemoteNotificationsWithApplication:nil];

// unregister from remote notifications
[manager unregisterForRemoteNotificationsWithApplication:nil];
```

### Handle Remote Notifications

Обработкой событий занимается объект, который реализует протокол `ELNAPSEventsHandler`.

Обработчики должны быть зарегистрированы заранее:

```objective-c
ELNAPSManager *manager = [ELNAPSManager new];
[manager.eventsHandler addNotificationHandler:handler];
```

При получении нотификаций, необходимо проксировать вызовы UIAppDelegate в обработчик событий:

```objective-c
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	[self.manager.eventsHandler application:application didReceiveRemoteNotification:userInfo];
}
```

### ELNAPSEventsHandlerChain

Библиотека предоставляет стандартный объект `ELNAPSEventsHandlerChain`, который позволяет зарегистрировать цепочку обработчиков.

После получения уведомления  `ELNAPSEventsHandlerChain` пытается найти обработчик `<ELNAPSNotificationHandler>`, который сможет его обработать. Первый обработчик, который возвращает `YES` в методе `shouldHandleNotification:forApplication:` , получает возможность обработать уведомления, после чего поиск обработчика завершается.

Объект `ELNAPSEventsHandlerChain` подписывается на нотификации `UIApplicationDidFinishLaunchingNotification`, чтобы обработать пуши, которые пришли во время старта приложения.

### ELNAPSNotificationHandler

Обработчики, должны соответствовать протоколу `ELNAPSNotificationHandler`:

```objective-c
@protocol ELNAPSNotificationHandler <NSObject>

@required
- (BOOL)shouldHandleNotification:(ELNAPSNotification *)notification forApplication:(UIApplication *)application;

- (UIBackgroundFetchResult)handleNotification:(ELNAPSNotification *)notification forApplication:(UIApplication *)application;

@end
```

Для обработки уведомления используется метод `handleNotification:forApplication:`:

```objective-c
- (UIBackgroundFetchResult)handleNotification:(ELNAPSNotification *)notification forApplication:(UIApplication *)application {
	NSLog(@"Received push notification with title %@", notification.alert.title);
	return UIBackgroundFetchResultNoData;
}
```

## Contribution

###Cocoapods

```sh
# download source code, fix bugs, implement new features

pod repo add legion https://github.com/elegion/ios-podspecs
pod repo push legion ELNPushServices.podspec
```