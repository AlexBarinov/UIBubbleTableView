//
//  ViewController.h
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"

@class UIBubbleTableView;

@interface ViewController : UIViewController <UIBubbleTableViewDataSource>
{
    IBOutlet UIBubbleTableView *bubbleTable;
    
    NSMutableArray *bubbleData;
}

@end
