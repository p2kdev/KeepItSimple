#import <libcolorpicker.h>
#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"

@interface FBSystemService : NSObject
  +(id)sharedInstance;
  -(void)exitAndRelaunch:(BOOL)arg1;
@end

@interface NCNotificationStructuredSectionList
-(void)clearAllNotificationRequests;
-(void)clearAll;
@property (nonatomic,retain) NSString * title;
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

static CGFloat indicatorOffsetX = 195;
static CGFloat indicatorOffsetY = 115;
static bool pullToClearEnabled = YES;
static CGFloat refreshControlScale = 0.8;
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
        if (@available(iOS 16, *))
          [self.masterList.incomingSectionList clearAll];
        else
  			  [self.masterList.incomingSectionList clearAllNotificationRequests];        

        UINotificationFeedbackGenerator *_hapticFeedbackGenerator = [[UINotificationFeedbackGenerator alloc] init];
        [_hapticFeedbackGenerator prepare];
        [_hapticFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeSuccess];        
  			//[self.masterList.historySectionList clearAllNotificationRequests];
  			//[self.masterList.missedSectionList clearAllNotificationRequests];
    }

  %end

  %hook SBMainDisplayPolicyAggregator

    -(BOOL)_allowsCapabilityCoverSheetSpotlightWithExplanation:(id)arg1
    {
      return pullToClearEnabled ? NO : %orig;
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

  -(BOOL)_isNotificationRequestForIncomingSection:(id)arg1
  {
  	return YES;
  }

  -(BOOL)_isNotificationRequestForHistorySection:(id)arg1
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

  //iOS14
  -(void)_migrateNotificationsFromList:(id)arg1 toList:(id)arg2 passingTest:(id)arg3 hideToList:(BOOL)arg4 clearRequests:(BOOL)arg5 filterPersistentRequests:(BOOL)arg6
  {
    return;
  }

  //iOS15
  -(void)_migrateNotificationsFromList:(id)arg1 toList:(id)arg2 passingTest:(id)arg3 filterRequestsPassingTest:(id)arg4 hideToList:(BOOL)arg5 clearRequests:(BOOL)arg6 filterForDestination:(BOOL)arg7 animateRemoval:(BOOL)arg8 reorderGroupNotifications:(BOOL)arg9
  {
    return;
  }  

  -(BOOL)_isNotificationRequest:(id)arg1 forSectionList:(NCNotificationStructuredSectionList*)arg2
  {
    if (arg2.title)
      return NO;
    else
      return YES;
  }

  %end

static void respring(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

static void reloadSettings() {

  static CFStringRef prefsKey = CFSTR("com.p2kdev.keepitsimple");
  CFPreferencesAppSynchronize(prefsKey);

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"customColor", prefsKey))) {
    customColor = [(id)CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"customColor", prefsKey)) stringValue];
  }  

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"offsetX", prefsKey))) {
    indicatorOffsetX = [(id)CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"offsetX", prefsKey)) floatValue];
  }  

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"offsetY", prefsKey))) {
    indicatorOffsetY = [(id)CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"offsetY", prefsKey)) floatValue];
  }  

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"refreshControlScale", prefsKey))) {
    refreshControlScale = [(id)CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"refreshControlScale", prefsKey)) floatValue];
  }    

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"pullToClearEnabled", prefsKey))) {
    pullToClearEnabled = [(id)CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"pullToClearEnabled", prefsKey)) boolValue];
  }      
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.p2kdev.keepitsimple.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadSettings();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, respring, CFSTR("com.p2kdev.keepitsimple.respring"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
