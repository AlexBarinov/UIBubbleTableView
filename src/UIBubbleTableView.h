//
//  UIBubbleTableView.h
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
//

#import <UIKit/UIKit.h>

#import "UIBubbleTableViewDataSource.h"
#import "UIBubbleTableViewCell.h"

@interface UIBubbleTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIBubbleTableViewCell *bubbleCell;
    
    NSDictionary *bubbleDictionary;
}

@property (nonatomic, strong) id<UIBubbleTableViewDataSource> bubbleDataSource;
@property (nonatomic) NSTimeInterval snapInterval;

@end
