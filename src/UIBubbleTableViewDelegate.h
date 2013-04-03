//
//  UIBubbleTableViewDelegate.h
//  UIBubbleTableViewExample
//
//  Created by Philip Kramarov on 4/2/13.
//
//

#import <Foundation/Foundation.h>

@class UIBubbleTableView;

@protocol UIBubbleTableViewDelegate <NSObject>

@optional
/**
 Called after the user tapped on the bubble
 @param tableView   The UIBubbleTableView that the method was called from.
 */
-(void)bubbleTableView:(UIBubbleTableView *)tableView didSelectBubbleAtIndex:(NSUInteger)index;

@end