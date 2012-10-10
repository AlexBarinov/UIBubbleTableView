//
//  UIBubbleTypingTableCell.h
//  UIBubbleTableViewExample
//
//  Created by Александр Баринов on 10/7/12.
//  Copyright (c) 2012 Stex Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableView.h"


@interface UIBubbleTypingTableViewCell : UITableViewCell

+ (CGFloat)height;

@property (nonatomic) NSBubbleTypingType type;
@property (nonatomic) BOOL showAvatar;

@end
