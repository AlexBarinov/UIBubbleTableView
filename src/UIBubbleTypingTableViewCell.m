//
//  UIBubbleTypingTableCell.m
//  UIBubbleTableViewExample
//
//  Created by Александр Баринов on 10/7/12.
//  Copyright (c) 2012 Stex Group. All rights reserved.
//

#import "UIBubbleTypingTableViewCell.h"

@interface UIBubbleTypingTableViewCell ()

@property (nonatomic, retain) UIImageView *typingImageView;

@end

@implementation UIBubbleTypingTableViewCell

@synthesize type = _type;
@synthesize typingImageView = _typingImageView;
@synthesize showAvatar = _showAvatar;

+ (CGFloat)height
{
    return 40.0;
}

- (void)setType:(NSBubbleTypingType)value
{
    if (!self.typingImageView)
    {
        self.typingImageView = [[UIImageView alloc] init];
        [self addSubview:self.typingImageView];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImage *bubbleImage = nil;
    CGFloat x = 0;
    
    if (value == NSBubbleTypingTypeMe)
    {
        bubbleImage = [UIImage imageNamed:@"typingMine.png"]; 
        x = self.frame.size.width - bubbleImage.size.width;
    }
    else
    {
        bubbleImage = [UIImage imageNamed:@"typingSomeone.png"]; 
        x = 0;
    }
    
    self.typingImageView.image = bubbleImage;
    self.typingImageView.frame = CGRectMake(x, 4, 73, 31);
}

@end
