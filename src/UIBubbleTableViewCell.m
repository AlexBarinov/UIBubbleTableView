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
@property (nonatomic, retain) UIView *oldCustomView;
@end

@implementation UIBubbleTableViewCell

@synthesize dataInternal = _dataInternal;
@synthesize oldCustomView = _oldCustomView;

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
	[self setupInternalData];
}

- (void) dealloc
{
    [_dataInternal release];
	_dataInternal = nil;
    [_oldCustomView release];
    _oldCustomView = nil;
    [super dealloc];
}


- (void)setDataInternal:(NSBubbleDataInternal *)value
{
	[value retain];
	[_dataInternal release];
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
    CGFloat imageOffsetX = 5.0;
    CGFloat imageOffsetY = 6.0;
    
    CGFloat height = self.dataInternal.data.view ? (CGRectGetHeight(self.dataInternal.data.view.frame) + imageOffsetY*2.0) : self.dataInternal.labelSize.height;
    CGFloat width = self.dataInternal.data.view ? (CGRectGetWidth(self.dataInternal.data.view.frame) + imageOffsetX*2.0) : self.dataInternal.labelSize.width;

    float x = (type == BubbleTypeSomeoneElse) ? 20 : self.frame.size.width - 20 - width;
    float y = 5 + (self.dataInternal.header ? 30 : 0);
    
    [self.oldCustomView removeFromSuperview];
    self.oldCustomView = nil;
        
    if (!self.dataInternal.data.view) {
        contentLabel.hidden = NO;
        contentLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        contentLabel.frame = CGRectMake(x, y, self.dataInternal.labelSize.width, self.dataInternal.labelSize.height);
        contentLabel.text = self.dataInternal.data.text;
    }
    else
    {
        contentLabel.hidden = YES;
        self.oldCustomView = self.dataInternal.data.view;
        [self.contentView addSubview:self.oldCustomView];
        self.oldCustomView.frame = CGRectMake(x+imageOffsetX-1.0, y+imageOffsetY+3.0, CGRectGetWidth(self.oldCustomView.frame), CGRectGetHeight(self.oldCustomView.frame));
    }
    if (type == BubbleTypeSomeoneElse)
    {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleSomeone.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 18, y - 4, width + 30, height + 15);
    }
    else {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleMine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 9, y - 4, width + 26, height + 15);
    }
}

@end
