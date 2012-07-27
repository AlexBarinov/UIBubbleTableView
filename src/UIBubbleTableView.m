//
//  UIBubbleTableView.m
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

#import "UIBubbleTableView.h"
#import "NSBubbleData.h"
#import "NSBubbleDataInternal.h"

@implementation UIBubbleTableView

@synthesize bubbleDataSource;
@synthesize snapInterval;

#pragma mark - Initializators

- (void)initializator
{
    // UITableView properties
    
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    assert(self.style == UITableViewStylePlain);
    
    self.delegate = self;
    self.dataSource = self;
    
    // UIBubbleTableView default properties
    
    self.snapInterval = 120;
}

- (id)init
{
    self = [super init];
    if (self) [self initializator];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self initializator];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self initializator];
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) [self initializator];
    return self;
}

#pragma mark - Override

- (void)reloadData
{
    // Cleaning up
    if (bubbleDictionary)
    {
        for (NSString *key in [bubbleDictionary allKeys])
        {
            NSMutableArray *array = [bubbleDictionary valueForKey:key];
            for (NSObject *object in array)
            {
                NSBubbleDataInternal *dataInternal = (NSBubbleDataInternal *)object;
                
                [dataInternal.data release];
                [dataInternal release];
            }
            [array release];
        }
        [bubbleDictionary release];
        bubbleDictionary = nil;
    }
    
    // Loading new data
    int count = 0;
    if (self.bubbleDataSource && (count = [self.bubbleDataSource rowsForBubbleTable:self]) > 0)
    {        
        bubbleDictionary = [[NSMutableDictionary alloc] init];
        NSMutableArray *bubbleData = [[NSMutableArray alloc] initWithCapacity:count];
        
        for (int i = 0; i < count; i++)
        {
            NSObject *object = [self.bubbleDataSource bubbleTableView:self dataForRow:i];
            assert([object isKindOfClass:[NSBubbleData class]]);
            [bubbleData addObject:[object retain]];
        }
        
        [bubbleData sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
        {

            NSBubbleData *bubbleData1 = (NSBubbleData *)obj1;
            NSBubbleData *bubbleData2 = (NSBubbleData *)obj2;
            
            return [bubbleData1.date compare:bubbleData2.date];            
        }];
        
        NSDate *last = [NSDate dateWithTimeIntervalSince1970:0];
        NSMutableArray *currentSection = nil;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        for (int i = 0; i < count; i++)
        {
            NSBubbleDataInternal *dataInternal = [[NSBubbleDataInternal alloc] init];
            dataInternal.data = (NSBubbleData *)[bubbleData objectAtIndex:i];
            
            // Calculating cell height
            dataInternal.labelSize = [(dataInternal.data.text ? dataInternal.data.text : @"") sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]] constrainedToSize:CGSizeMake(220, 9999) lineBreakMode:UILineBreakModeWordWrap];
            
            dataInternal.height = dataInternal.labelSize.height + 5 + 11;
            
            dataInternal.header = nil;
            
            if ([dataInternal.data.date timeIntervalSinceDate:last] > snapInterval)
            {
                currentSection = [[NSMutableArray alloc] init];
                [bubbleDictionary setValue:currentSection forKey:[NSString stringWithFormat:@"%d",i]];
                dataInternal.header = [dateFormatter stringFromDate:dataInternal.data.date];
                dataInternal.height += 30;
            }

            [currentSection addObject:dataInternal];
            last = dataInternal.data.date;
        }
        
        [dateFormatter release];
    }
    
    [super reloadData];
}

#pragma mark - UITableViewDelegate implementation

#pragma mark - UITableViewDataSource implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!bubbleDictionary) return 0;
    return [[bubbleDictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[[bubbleDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:section];
    return [[bubbleDictionary valueForKey:key] count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[[bubbleDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:indexPath.section];
    NSBubbleDataInternal *dataInternal = ((NSBubbleDataInternal *)[[bubbleDictionary valueForKey:key] objectAtIndex:indexPath.row]);

    return dataInternal.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"tblBubbleCell";
    
    NSString *key = [[[bubbleDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:indexPath.section];
    NSBubbleDataInternal *dataInternal = ((NSBubbleDataInternal *)[[bubbleDictionary valueForKey:key] objectAtIndex:indexPath.row]);
    
    UIBubbleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"UIBubbleTableViewCell" owner:self options:nil];
        cell = bubbleCell;
    }
    
    cell.dataInternal = dataInternal;
    return cell;
}

@end
