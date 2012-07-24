//
//  UIBubbleTableViewCell.h
//  UIBubbleTableViewExample
//
//  Created by Alex Barinov on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSBubbleDataInternal.h"

@interface UIBubbleTableViewCell : UITableViewCell
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *contentLabel;
    IBOutlet UIImageView *bubbleImage;
}

@property (nonatomic, strong) NSBubbleDataInternal *dataInternal;

@end
