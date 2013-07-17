//
//  UIBubbleTableView.h
//
//  Created by Alex Barinov
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//

#import <UIKit/UIKit.h>

#import "BTVBubbleTableViewDataSource.h"
#import "BTVBubbleTableViewCell.h"

typedef enum _BTVBubbleTypingType
{
    NSBubbleTypingTypeNobody = 0,
    NSBubbleTypingTypeMe = 1,
    NSBubbleTypingTypeSomebody = 2
} BTVBubbleTypingType;

@interface BTVBubbleTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) IBOutlet id<BTVBubbleTableViewDataSource> bubbleDataSource;
@property (nonatomic) NSTimeInterval snapInterval;
@property (nonatomic) BTVBubbleTypingType typingBubble;
@property (nonatomic) BOOL showAvatars;
@property (nonatomic) BOOL showUsernameLabel;
@property (nonatomic) BOOL scrollOnActivity;
-(void)scrollToBottomAnimated:(BOOL)animated;

@end
