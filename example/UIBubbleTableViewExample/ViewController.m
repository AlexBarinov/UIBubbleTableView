//
//  ViewController.m
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

#import "ViewController.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    bubbleTable.bubbleDataSource = self;
    
    bubbleData = [[NSMutableArray alloc] initWithObjects:
                  [NSBubbleData dataWithText:@"Marge, there's something that I want to ask you, but I'm afraid, because if you say no, it will destroy me and make me a criminal." andDate:[NSDate dateWithTimeIntervalSinceNow:-300] andType:BubbleTypeMine],
                  [NSBubbleData dataWithText:@"Well, I haven't said no to you yet, have I?" andDate:[NSDate dateWithTimeIntervalSinceNow:-280] andType:BubbleTypeSomeoneElse],
                  [NSBubbleData dataWithText:@"Marge... Oh, damn it." andDate:[NSDate dateWithTimeIntervalSinceNow:0] andType:BubbleTypeMine],
                  [NSBubbleData dataWithText:@"What's wrong?" andDate:[NSDate dateWithTimeIntervalSinceNow:300]  andType:BubbleTypeSomeoneElse],
                  [NSBubbleData dataWithText:@"Ohn I wrote down what I wanted to say on a card.." andDate:[NSDate dateWithTimeIntervalSinceNow:395]  andType:BubbleTypeMine],
                  [NSBubbleData dataWithText:@"The stupid thing must have fallen out of my pocket." andDate:[NSDate dateWithTimeIntervalSinceNow:400]  andType:BubbleTypeMine],
                  nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

@end
