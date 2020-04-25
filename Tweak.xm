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

static CGFloat indicatorOffsetX = 0;
static CGFloat indicatorOffsetY = 0;
//static int fontSize = 14;
static NSString *customColor = @"#FFFFFF";

%hook NCNotificationMasterList

	-(NCNotificationListView *)masterListView
	//-(void)setMasterListView:(NCNotificationListView *)arg1
	{
		NCNotificationListView *orig = %orig;
		if (!orig.refreshControl)
		{
			UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
      //refreshControl.bounds = CGRectOffset(refreshControl.bounds, 0, -150);
			refreshControl.bounds = CGRectMake(refreshControl.bounds.origin.x + indicatorOffsetX,refreshControl.bounds.origin.y + indicatorOffsetY,refreshControl.bounds.size.width,refreshControl.bounds.size.height);
			//refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to clear Notifications!" attributes:@{NSForegroundColorAttributeName:LCPParseColorString(customFontColor, @"#FFFFFF"),
			//																																										NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
			refreshControl.tintColor = LCPParseColorString(customColor, @"#FFFFFF");
			[refreshControl addTarget:self action:@selector(clearNotifications:) forControlEvents:UIControlEventValueChanged];
			orig.refreshControl = refreshControl;
		}

		return orig;
	}

  %new
  - (void)clearNotifications:(UIRefreshControl *)refreshControl
  {
      AudioServicesPlaySystemSound(1520);
			[self.incomingSectionList clearAllNotificationRequests];
			[self.historySectionList clearAllNotificationRequests];
			[self.missedSectionList clearAllNotificationRequests];
      [refreshControl endRefreshing];
  }

%end


%hook NCNotificationListSectionRevealHintView

- (void)layoutSubviews {
	return;
}

%end

// %hook NCNotificationStructuredSectionList
//
// 	-(BOOL)isHistorySection
// 	{
// 		return NO;
// 	}
//
// 	-(void)setHistorySection:(BOOL)arg1
// 	{
// 		arg1 = NO;
// 		%orig;
// 	}
// %end

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

// -(void)setHistorySectionList:(id)arg1
// {
// 	return;
// }
// -(void)setMissedSectionList:(id)arg1
// {
// 	return;
// }

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

// -(id)historySectionList
// {
// 	return nil;
// }
//
// -(id)missedSectionList
// {
// 	return nil;
// }

// -(NSMutableArray *)notificationSections
// {
// 	NSMutableArray *originalArrayOfItems = %orig;
// 	if (originalArrayOfItems.count > 1)
// 		[originalArrayOfItems removeObjectsInRange:NSMakeRange(0, originalArrayOfItems.count-2)];
// 	return originalArrayOfItems;
//
// 	//
// 	// NSMutableArray *discardedItems = [NSMutableArray array];
// 	//
// 	// for (NCNotificationStructuredSectionList * section in originalArrayOfItems)
// 	// {
// 	// 	if (section.historySection)
// 	// 		[discardedItems addObject:section];
// 	// }
// 	//
// 	// [originalArrayOfItems removeObjectsInArray:discardedItems];
//
// }

// -(void)setNotificationSections:(NSMutableArray *)arg1
// {
// 	if (self.incomingSectionList)
// 	{
// 		[arg1 removeAllObjects];
// 		[arg1 addObject:self.incomingSectionList];
// 	}
//
// 	%orig;
// }


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
		//fontSize = [prefs objectForKey:@"fontSize"] ? [[prefs objectForKey:@"fontSize"] intValue] : fontSize;
	}
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.p2kdev.keepitsimple.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadSettings();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, respring, CFSTR("com.p2kdev.keepitsimple.respring"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
