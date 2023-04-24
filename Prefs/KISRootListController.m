#import <Preferences/Preferences.h>
#import <libcolorpicker.h>

@interface KISRootListController : PSListController
@end

@implementation KISRootListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"KeepItSimple" target:self];
	}
	return _specifiers;
}

- (void)visitTwitter {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/p2kdev"]];
}

- (void)respring {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.p2kdev.keepitsimple.respring"), NULL, NULL, YES);
}

@end
