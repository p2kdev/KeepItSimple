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
	@property (nonatomic,retain) NCNotificationStructuredSectionList * incomingSectionList;                                    //@synthesize incomingSectionList=_incomingSectionList - In the implementation block
	@property (nonatomic,retain) NCNotificationStructuredSectionList * historySectionList;                                     //@synthesize historySectionList=_historySectionList - In the implementation block
	@property (nonatomic,retain) NCNotificationStructuredSectionList * missedSectionList;
@end

@interface NCNotificationStructuredListViewController : UIViewController
  @property (nonatomic,retain) NCNotificationMasterList * masterList;
  @property (nonatomic,retain) NCNotificationListView * masterListView;
@end

static CGFloat indicatorOffsetX = 190;
static CGFloat indicatorOffsetY = 50;
static bool pullToClearEnabled = YES;
static CGFloat refreshControlScale = 0.5;
//static int fontSize = 14;
static NSString *customColor = @"#FFFFFF";

//Pull to Clear Notifications
%hook NCNotificationStructuredListViewController

	-(void)viewDidLoad
	//-(void)setMasterListView:(NCNotificationListView *)arg1
	{
		%orig;
		if (!self.masterListView.refreshControl && pullToClearEnabled)
		{
			UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
      //refreshControl.bounds = CGRectOffset(refreshControl.bounds, 0, -150);
			//refreshControl.bounds = CGRectMake(refreshControl.bounds.origin.x + indicatorOffsetX,refreshControl.bounds.origin.y + indicatorOffsetY,refreshControl.bounds.size.width,refreshControl.bounds.size.height);
			//refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Clear all Notifications!" attributes:@{NSForegroundColorAttributeName:LCPParseColorString(customColor, @"#FFFFFF"),NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
			refreshControl.tintColor = LCPParseColorString(customColor, @"#FFFFFF");
      refreshControl.transform = CGAffineTransformMakeScale(refreshControlScale,refreshControlScale);
			[refreshControl addTarget:self action:@selector(clearNotifications:) forControlEvents:UIControlEventValueChanged];
			self.masterListView.refreshControl = refreshControl;
      self.masterListView.refreshControl.translatesAutoresizingMaskIntoConstraints = NO;
      [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.masterListView.refreshControl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant: indicatorOffsetX]];
      [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.masterListView.refreshControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant: indicatorOffsetY]];
		}
	}

  %new
  - (void)clearNotifications:(UIRefreshControl *)refreshControl
  {
      [refreshControl endRefreshing];
      AudioServicesPlaySystemSound(1520);
			[self.masterList.incomingSectionList clearAllNotificationRequests];
			//[self.masterList.historySectionList clearAllNotificationRequests];
			//[self.masterList.missedSectionList clearAllNotificationRequests];
  }

%end

//Hides the No Older Notification Text
%hook NCNotificationListSectionRevealHintView

- (void)layoutSubviews {
	return;
}

%end

//Single List of Notifications
%hook NCNotificationMasterList

-(void)setNotificationListStalenessEventTracker:(id)arg1
{
	return;
}

-(id)notificationListStalenessEventTracker
{
	return nil;
}

-(BOOL)_isNotificationRequestForIncomingSection:(id)arg1
{
	return YES;
}

-(BOOL)_isNotificationRequestForHistorySection:(id)arg1
{
	return NO;
}

-(BOOL)isMissedSectionActive
{
	return NO;
}

-(void)setMissedSectionActive:(BOOL)arg1
{
	%orig(NO);
}

-(BOOL)notificationStructuredSectionList:(id)arg1 shouldFilterNotificationRequest:(id)arg2
{
	return NO;
}

-(void)setShouldAllowNotificationHistoryReveal:(BOOL)arg1
{
	%orig(NO);
}

-(void)setRevealCoordinator:(id)arg1
{
	return;
}

-(id)revealCoordinator
{
	return nil;
}

-(BOOL)isNotificationHistoryRevealed
{
	return YES;
}

-(BOOL)shouldAllowNotificationHistoryReveal
{
	return NO;
}

-(BOOL)notificationListRevealCoordinatorShouldAllowReveal:(id)arg1
{
	return NO;
}

-(void)_migrateNotificationsFromList:(id)arg1 toList:(id)arg2 passingTest:(id)arg3 hideToList:(BOOL)arg4 clearRequests:(BOOL)arg5
{
	return;
}

-(void)migrateNotifications
{
	return;
}
%end

static void respring(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

static void reloadSettings() {

	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.p2kdev.keepitsimple.plist"];
	if(prefs)
	{
		//wantsCustomFontColor = [prefs objectForKey:@"wantsCustomColor"] ? [[prefs objectForKey:@"wantsCustomColor"] boolValue] : wantsCustomFontColor;
		customColor = [prefs objectForKey:@"customColor"] ? [[prefs objectForKey:@"customColor"] stringValue] : customColor;
		indicatorOffsetX = [prefs objectForKey:@"offsetX"] ? [[prefs objectForKey:@"offsetX"] floatValue] : indicatorOffsetX;
		indicatorOffsetY = [prefs objectForKey:@"offsetY"] ? [[prefs objectForKey:@"offsetY"] floatValue] : indicatorOffsetY;
    refreshControlScale = [prefs objectForKey:@"refreshControlScale"] ? [[prefs objectForKey:@"refreshControlScale"] floatValue] : refreshControlScale;
    pullToClearEnabled = [prefs objectForKey:@"pullToClearEnabled"] ? [[prefs objectForKey:@"pullToClearEnabled"] boolValue] : pullToClearEnabled;
		//fontSize = [prefs objectForKey:@"fontSize"] ? [[prefs objectForKey:@"fontSize"] intValue] : fontSize;
	}
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.p2kdev.keepitsimple.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadSettings();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, respring, CFSTR("com.p2kdev.keepitsimple.respring"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
