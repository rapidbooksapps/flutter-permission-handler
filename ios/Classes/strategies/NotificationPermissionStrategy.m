////
////  NotificationPermissionStrategy.m
////  permission_handler
////
////  Created by Tong on 2019/10/21.
////
//
//#import "NotificationPermissionStrategy.h"
//
//@implementation NotificationPermissionStrategy
//
//- (PermissionStatus)checkPermissionStatus:(PermissionGroup)permission {
//  return [NotificationPermissionStrategy permissionStatus];
//}
//
//- (ServiceStatus)checkServiceStatus:(PermissionGroup)permission {
//  return ServiceStatusNotApplicable;
//}
//
//- (void)requestPermission:(PermissionGroup)permission completionHandler:(PermissionStatusHandler)completionHandler {
//  PermissionStatus status = [self checkPermissionStatus:permission];
//  if (status != PermissionStatusUnknown) {
//    completionHandler(status);
//    return;
//  }
//  dispatch_async(dispatch_get_main_queue(), ^{
//    if(@available(iOS 10.0, *)) {
//      UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//      UNAuthorizationOptions authorizationOptions = 0;
//      authorizationOptions += UNAuthorizationOptionSound;
//      authorizationOptions += UNAuthorizationOptionAlert;
//      authorizationOptions += UNAuthorizationOptionBadge;
//      [center requestAuthorizationWithOptions:(authorizationOptions) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (!granted || error != nil) {
//          completionHandler(PermissionStatusDenied);
//          return;
//        }
//      }];
//    } else {
//      UIUserNotificationType notificationTypes = 0;
//      notificationTypes |= UIUserNotificationTypeSound;
//      notificationTypes |= UIUserNotificationTypeAlert;
//      notificationTypes |= UIUserNotificationTypeBadge;
//      UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
//      [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    }
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    completionHandler(PermissionStatusGranted);
//  });
//}
//
//+ (PermissionStatus)permissionStatus {
//  __block PermissionStatus permissionStatus = PermissionStatusGranted;
//  if (@available(iOS 10 , *)) {
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//      if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
//        permissionStatus = PermissionStatusDenied;
//      } else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
//        permissionStatus = PermissionStatusUnknown;
//      }
//      dispatch_semaphore_signal(sem);
//    }];
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//  } else if (@available(iOS 8 , *)) {
//    UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//    if (setting.types == UIUserNotificationTypeNone) permissionStatus = PermissionStatusDenied;
//  } else {
//    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//    if (type == UIUserNotificationTypeNone) permissionStatus = PermissionStatusDenied;
//  }
//  return permissionStatus;
//}
//
//@end
