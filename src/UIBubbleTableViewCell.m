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
    float y = 15 + (value.header ? 30 : 0);
    
    contentLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    contentLabel.frame = CGRectMake(x, y, value.labelSize.width, value.labelSize.height);
    contentLabel.text = value.data.text;
    
    if (type == BubbleTypeSomeoneElse)
    {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleSomeoneGray.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:13];        
        bubbleImage.frame = CGRectMake(x - 18, y - 5, value.labelSize.width + 26, value.labelSize.height + 13);
    }
    else {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleMineGreen.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:13];
        bubbleImage.frame = CGRectMake(x - 9, y - 5, value.labelSize.width + 26, value.labelSize.height + 13);
    }
}


@end
