#line 1 "Tweak.xm"
#import <libcolorpicker.h>
#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"

@interface FBSystemService : NSObject
  +(id)sharedInstance;
  -(void)exitAndRelaunch:(BOOL)arg1;
@end

@interface NCNotificationStructuredSectionList
-(void)clearAllNotificationRequests;
@end

@interface NCNotificationListView : UIScrollView

@end

@interface NCNotificationMasterList
	@property (nonatomic,retain) NCNotificationListView * masterListView;
	@property (nonatomic,retain) NCNotificationStructuredSectionList * incomingSectionList;                                    
	@property (nonatomic,retain) NCNotificationStructuredSectionList * historySectionList;                                     
	@property (nonatomic,retain) NCNotificationStructuredSectionList * missedSectionList;
@end

@interface NCNotificationStructuredListViewController : UIViewController
  @property (nonatomic,retain) NCNotificationMasterList * masterList;
  @property (nonatomic,retain) NCNotificationListView * masterListView;
@end

static CGFloat indicatorOffsetX = 150;
static CGFloat indicatorOffsetY = 50;
static int fontSize = 14;
static NSString *customColor = @"#FFFFFF";



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class NCNotificationListSectionRevealHintView; @class NCNotificationMasterList; @class NCNotificationStructuredListViewController; @class FBSystemService; 
static void (*_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$clearNotifications$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST, SEL, UIRefreshControl *); static void (*_logos_orig$_ungrouped$NCNotificationListSectionRevealHintView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL NCNotificationListSectionRevealHintView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationListSectionRevealHintView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL NCNotificationListSectionRevealHintView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationMasterList$setNotificationListStalenessEventTracker$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$NCNotificationMasterList$setNotificationListStalenessEventTracker$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$NCNotificationMasterList$notificationListStalenessEventTracker)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$NCNotificationMasterList$notificationListStalenessEventTracker(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$_isNotificationRequestForIncomingSection$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$_isNotificationRequestForIncomingSection$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$_isNotificationRequestForHistorySection$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$_isNotificationRequestForHistorySection$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$isMissedSectionActive)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$isMissedSectionActive(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationMasterList$setMissedSectionActive$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$NCNotificationMasterList$setMissedSectionActive$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, BOOL); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$notificationStructuredSectionList$shouldFilterNotificationRequest$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id, id); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$notificationStructuredSectionList$shouldFilterNotificationRequest$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$NCNotificationMasterList$setShouldAllowNotificationHistoryReveal$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$NCNotificationMasterList$setShouldAllowNotificationHistoryReveal$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$NCNotificationMasterList$setRevealCoordinator$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$NCNotificationMasterList$setRevealCoordinator$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$NCNotificationMasterList$revealCoordinator)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$NCNotificationMasterList$revealCoordinator(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$isNotificationHistoryRevealed)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$isNotificationHistoryRevealed(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$shouldAllowNotificationHistoryReveal)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$shouldAllowNotificationHistoryReveal(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$NCNotificationMasterList$notificationListRevealCoordinatorShouldAllowReveal$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$NCNotificationMasterList$notificationListRevealCoordinatorShouldAllowReveal$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$NCNotificationMasterList$_migrateNotificationsFromList$toList$passingTest$hideToList$clearRequests$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id, id, id, BOOL, BOOL); static void _logos_method$_ungrouped$NCNotificationMasterList$_migrateNotificationsFromList$toList$passingTest$hideToList$clearRequests$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL, id, id, id, BOOL, BOOL); static void (*_logos_orig$_ungrouped$NCNotificationMasterList$migrateNotifications)(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationMasterList$migrateNotifications(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FBSystemService(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FBSystemService"); } return _klass; }
#line 36 "Tweak.xm"




	static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd)  {
		_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad(self, _cmd);
		if (!self.masterListView.refreshControl)
		{
			UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
      
			
			refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Clear all Notifications!" attributes:@{NSForegroundColorAttributeName:LCPParseColorString(customColor, @"#FFFFFF"),NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
			refreshControl.tintColor = LCPParseColorString(customColor, @"#FFFFFF");
			[refreshControl addTarget:self action:@selector(clearNotifications:) forControlEvents:UIControlEventValueChanged];
			self.masterListView.refreshControl = refreshControl;
      self.masterListView.refreshControl.translatesAutoresizingMaskIntoConstraints = NO;
      [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.masterListView.refreshControl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant: indicatorOffsetX]];
      [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.masterListView.refreshControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant: indicatorOffsetY]];
		}
	}

  

  static void _logos_method$_ungrouped$NCNotificationStructuredListViewController$clearNotifications$(_LOGOS_SELF_TYPE_NORMAL NCNotificationStructuredListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIRefreshControl * refreshControl) {
      AudioServicesPlaySystemSound(1520);
			[self.masterList.incomingSectionList clearAllNotificationRequests];
			[self.masterList.historySectionList clearAllNotificationRequests];
			[self.masterList.missedSectionList clearAllNotificationRequests];
      [refreshControl endRefreshing];
  }






static void _logos_method$_ungrouped$NCNotificationListSectionRevealHintView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL NCNotificationListSectionRevealHintView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return;
}







static void _logos_method$_ungrouped$NCNotificationMasterList$setNotificationListStalenessEventTracker$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	return;
}


static id _logos_method$_ungrouped$NCNotificationMasterList$notificationListStalenessEventTracker(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return nil;
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$_isNotificationRequestForIncomingSection$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	return YES;
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$_isNotificationRequestForHistorySection$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	return NO;
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$isMissedSectionActive(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return NO;
}


static void _logos_method$_ungrouped$NCNotificationMasterList$setMissedSectionActive$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
	_logos_orig$_ungrouped$NCNotificationMasterList$setMissedSectionActive$(self, _cmd, NO);
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$notificationStructuredSectionList$shouldFilterNotificationRequest$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
	return NO;
}


static void _logos_method$_ungrouped$NCNotificationMasterList$setShouldAllowNotificationHistoryReveal$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
	_logos_orig$_ungrouped$NCNotificationMasterList$setShouldAllowNotificationHistoryReveal$(self, _cmd, NO);
}


static void _logos_method$_ungrouped$NCNotificationMasterList$setRevealCoordinator$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	return;
}


static id _logos_method$_ungrouped$NCNotificationMasterList$revealCoordinator(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return nil;
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$isNotificationHistoryRevealed(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return YES;
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$shouldAllowNotificationHistoryReveal(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return NO;
}


static BOOL _logos_method$_ungrouped$NCNotificationMasterList$notificationListRevealCoordinatorShouldAllowReveal$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	return NO;
}


static void _logos_method$_ungrouped$NCNotificationMasterList$_migrateNotificationsFromList$toList$passingTest$hideToList$clearRequests$(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, BOOL arg4, BOOL arg5) {
	return;
}


static void _logos_method$_ungrouped$NCNotificationMasterList$migrateNotifications(_LOGOS_SELF_TYPE_NORMAL NCNotificationMasterList* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return;
}


static void respring(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  [[_logos_static_class_lookup$FBSystemService() sharedInstance] exitAndRelaunch:YES];
}

static void reloadSettings() {

	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.p2kdev.keepitsimple.plist"];
	if(prefs)
	{
		
		customColor = [prefs objectForKey:@"customColor"] ? [[prefs objectForKey:@"customColor"] stringValue] : customColor;
		indicatorOffsetX = [prefs objectForKey:@"offsetX"] ? [[prefs objectForKey:@"offsetX"] floatValue] : indicatorOffsetX;
		indicatorOffsetY = [prefs objectForKey:@"offsetY"] ? [[prefs objectForKey:@"offsetY"] floatValue] : indicatorOffsetY;
		
	}
}

static __attribute__((constructor)) void _logosLocalCtor_3d730dea(int __unused argc, char __unused **argv, char __unused **envp) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.p2kdev.keepitsimple.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadSettings();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, respring, CFSTR("com.p2kdev.keepitsimple.respring"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$NCNotificationStructuredListViewController = objc_getClass("NCNotificationStructuredListViewController"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$NCNotificationStructuredListViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIRefreshControl *), strlen(@encode(UIRefreshControl *))); i += strlen(@encode(UIRefreshControl *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationStructuredListViewController, @selector(clearNotifications:), (IMP)&_logos_method$_ungrouped$NCNotificationStructuredListViewController$clearNotifications$, _typeEncoding); }Class _logos_class$_ungrouped$NCNotificationListSectionRevealHintView = objc_getClass("NCNotificationListSectionRevealHintView"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationListSectionRevealHintView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$NCNotificationListSectionRevealHintView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$NCNotificationListSectionRevealHintView$layoutSubviews);Class _logos_class$_ungrouped$NCNotificationMasterList = objc_getClass("NCNotificationMasterList"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(setNotificationListStalenessEventTracker:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$setNotificationListStalenessEventTracker$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$setNotificationListStalenessEventTracker$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(notificationListStalenessEventTracker), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$notificationListStalenessEventTracker, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$notificationListStalenessEventTracker);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(_isNotificationRequestForIncomingSection:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$_isNotificationRequestForIncomingSection$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$_isNotificationRequestForIncomingSection$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(_isNotificationRequestForHistorySection:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$_isNotificationRequestForHistorySection$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$_isNotificationRequestForHistorySection$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(isMissedSectionActive), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$isMissedSectionActive, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$isMissedSectionActive);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(setMissedSectionActive:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$setMissedSectionActive$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$setMissedSectionActive$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(notificationStructuredSectionList:shouldFilterNotificationRequest:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$notificationStructuredSectionList$shouldFilterNotificationRequest$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$notificationStructuredSectionList$shouldFilterNotificationRequest$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(setShouldAllowNotificationHistoryReveal:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$setShouldAllowNotificationHistoryReveal$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$setShouldAllowNotificationHistoryReveal$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(setRevealCoordinator:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$setRevealCoordinator$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$setRevealCoordinator$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(revealCoordinator), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$revealCoordinator, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$revealCoordinator);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(isNotificationHistoryRevealed), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$isNotificationHistoryRevealed, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$isNotificationHistoryRevealed);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(shouldAllowNotificationHistoryReveal), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$shouldAllowNotificationHistoryReveal, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$shouldAllowNotificationHistoryReveal);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(notificationListRevealCoordinatorShouldAllowReveal:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$notificationListRevealCoordinatorShouldAllowReveal$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$notificationListRevealCoordinatorShouldAllowReveal$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(_migrateNotificationsFromList:toList:passingTest:hideToList:clearRequests:), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$_migrateNotificationsFromList$toList$passingTest$hideToList$clearRequests$, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$_migrateNotificationsFromList$toList$passingTest$hideToList$clearRequests$);MSHookMessageEx(_logos_class$_ungrouped$NCNotificationMasterList, @selector(migrateNotifications), (IMP)&_logos_method$_ungrouped$NCNotificationMasterList$migrateNotifications, (IMP*)&_logos_orig$_ungrouped$NCNotificationMasterList$migrateNotifications);} }
#line 179 "Tweak.xm"
