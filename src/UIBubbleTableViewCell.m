//
//  UIBubbleTableViewCell.m
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
//
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//


#import "UIBubbleTableViewCell.h"
#import "NSBubbleData.h"

@interface UIBubbleTableViewCell ()
- (void) setupInternalData;
@end

@implementation UIBubbleTableViewCell

@synthesize dataInternal = _dataInternal;

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
	[self setupInternalData];
}

#ifndef ARC_ENABLED
- (void) dealloc
{
    [_dataInternal release];
	_dataInternal = nil;
    [super dealloc];
}
#endif


- (void)setDataInternal:(NSBubbleDataInternal *)value
{
#ifndef ARC_ENABLED
	[value retain];
	[_dataInternal release];
#endif
	_dataInternal = value;
	[self setupInternalData];
}

- (void) setupInternalData
{
    if (self.dataInternal.header)
    {
        headerLabel.hidden = NO;
        headerLabel.text = self.dataInternal.header;
    }
    else
    {
        headerLabel.hidden = YES;
    }
    
    NSBubbleType type = self.dataInternal.data.type;
    
    float avatarOffset = self.dataInternal.data.avatar ? 75 : 0;
    
    float x = (type == BubbleTypeSomeoneElse) ? 20 + avatarOffset : self.frame.size.width - 20 - self.dataInternal.labelSize.width - avatarOffset;
    float y = 5 + (self.dataInternal.header ? 30 : 0);
    
    contentLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    contentLabel.frame = CGRectMake(x, y, self.dataInternal.labelSize.width, self.dataInternal.labelSize.height);
    contentLabel.text = self.dataInternal.data.text;
    
    if (type == BubbleTypeSomeoneElse)
    {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleSomeone.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 18, y - 4, self.dataInternal.labelSize.width + 30, self.dataInternal.labelSize.height + 15);
    }
    else {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleMine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 9, y - 4, self.dataInternal.labelSize.width + 26, self.dataInternal.labelSize.height + 15);
    }
    
    avatarImage.image = self.dataInternal.data.avatar;
    if (avatarOffset > 0)
    {
        CGRect avatarFrame = avatarImage.frame;
        // avatar is 17 px from edge
        avatarFrame.origin.x = type == BubbleTypeSomeoneElse ? 17 : self.frame.size.width - 17 - avatarFrame.size.width;
        // align the bottom of the avatar with the bottom of the chat bubble
        avatarFrame.origin.y = bubbleImage.frame.origin.y + bubbleImage.frame.size.height - avatarFrame.size.height;
        avatarImage.frame = avatarFrame;
    }
}

@end
