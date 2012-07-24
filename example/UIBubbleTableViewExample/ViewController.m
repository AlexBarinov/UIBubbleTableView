//
//  ViewController.m
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
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
                  [[NSBubbleData alloc] initWithText:@"Hi Kate. This is Alex." andDate:[NSDate dateWithTimeIntervalSinceNow:-300] andType:BubbleTypeMine],
                  [[NSBubbleData alloc] initWithText:@"Hi Alex. How you doing today? Wanna take a long walk? The weather is perfect!" andDate:[NSDate dateWithTimeIntervalSinceNow:-280] andType:BubbleTypeSomeoneElse],
                  [[NSBubbleData alloc] initWithText:@"Yes, sure. See you at 8." andDate:[NSDate dateWithTimeIntervalSinceNow:0] andType:BubbleTypeMine],
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
