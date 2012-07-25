//
//  UIBubbleTableViewCell.m
//  UIBubbleTableViewExample
//
//  Created by Alex Barinov on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIBubbleTableViewCell.h"
#import "NSBubbleData.h"

@implementation UIBubbleTableViewCell

@synthesize dataInternal;

- (void)setDataInternal:(NSBubbleDataInternal *)value
{
    if (value.header)
    {
        headerLabel.hidden = NO;
        headerLabel.text = value.header;        
    }
    else
    {
        headerLabel.hidden = YES;
    }
    
    NSBubbleType type = value.data.type;
    
    float x = (type == BubbleTypeSomeoneElse) ? 20 : self.frame.size.width - 20 - value.labelSize.width;
    float y = 5 + (value.header ? 30 : 0);
    
    contentLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    contentLabel.frame = CGRectMake(x, y, value.labelSize.width, value.labelSize.height);
    contentLabel.text = value.data.text;
    
    if (type == BubbleTypeSomeoneElse)
    {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleSomeone.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];        
        bubbleImage.frame = CGRectMake(x - 18, y - 4, value.labelSize.width + 30, value.labelSize.height + 15);
    }
    else {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleMine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 9, y - 4, value.labelSize.width + 26, value.labelSize.height + 15);
    }
}


@end
