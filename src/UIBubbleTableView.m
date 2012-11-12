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

@interface UIBubbleTableView ()

@property (nonatomic, retain) NSMutableDictionary *bubbleDictionary;

@end

@implementation UIBubbleTableView

@synthesize bubbleDataSource = _bubbleDataSource;
@synthesize snapInterval = _snapInterval;
@synthesize bubbleDictionary = _bubbleDictionary;
@synthesize typingBubble = _typingBubble;

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
    self.typingBubble = NSBubbleTypingTypeMe;
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

#ifndef ARC_ENABLED
- (void)dealloc
{
    [_bubbleDictionary release];
	_bubbleDictionary = nil;
	_bubbleDataSource = nil;
    [super dealloc];
}
#endif

#pragma mark - Override

- (void)reloadData
{
    // Cleaning up
	self.bubbleDictionary = nil;
    
    // Loading new data
    int count = 0;
#ifndef ARC_ENABLED
    self.bubbleDictionary = [[[NSMutableDictionary alloc] init] autorelease];
#else
    self.bubbleDictionary = [[NSMutableDictionary alloc] init];
#endif
    
    if (self.bubbleDataSource && (count = [self.bubbleDataSource rowsForBubbleTable:self]) > 0)
    {
#ifndef ARC_ENABLED
        NSMutableArray *bubbleData = [[[NSMutableArray alloc] initWithCapacity:count] autorelease];
#else
        NSMutableArray *bubbleData = [[NSMutableArray alloc] initWithCapacity:count];
#endif
        
        for (int i = 0; i < count; i++)
        {
            NSObject *object = [self.bubbleDataSource bubbleTableView:self dataForRow:i];
            assert([object isKindOfClass:[NSBubbleData class]]);
            [bubbleData addObject:object];
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
#ifndef ARC_ENABLED
            NSBubbleDataInternal *dataInternal = [[[NSBubbleDataInternal alloc] init] autorelease];
#else
            NSBubbleDataInternal *dataInternal = [[NSBubbleDataInternal alloc] init];
#endif
            
            dataInternal.data = (NSBubbleData *)[bubbleData objectAtIndex:i];
            dataInternal.type = NSBubbleDataTypeNormalBubble;
            
            // Calculating cell height
            dataInternal.labelSize = [(dataInternal.data.text ? dataInternal.data.text : @"") sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]] constrainedToSize:CGSizeMake(220, 9999) lineBreakMode:UILineBreakModeWordWrap];
            
            dataInternal.height = dataInternal.labelSize.height;
            
            // Bump height if avatar is rather large compared to text size
            if (dataInternal.data.avatar && dataInternal.height < (dataInternal.data.avatar.size.height + 10))
                dataInternal.height = dataInternal.data.avatar.size.height + 10;
            dataInternal.height += 5 + 11; // height padding
            
            dataInternal.header = nil;
            
            if ([dataInternal.data.date timeIntervalSinceDate:last] > self.snapInterval)
            {
#ifndef ARC_ENABLED
                currentSection = [[[NSMutableArray alloc] init] autorelease];
#else
                currentSection = [[NSMutableArray alloc] init];
#endif
                [self.bubbleDictionary setObject:currentSection forKey:[NSString stringWithFormat:@"%d", i]];
                dataInternal.header = [dateFormatter stringFromDate:dataInternal.data.date];
                dataInternal.height += 30;
            }

            [currentSection addObject:dataInternal];
            last = dataInternal.data.date;
        }
        
#ifndef ARC_ENABLED
        [dateFormatter release];
#endif
    }
    
    // Adding the typing bubble at the end of the table
    
    if (self.typingBubble != NSBubbleTypingTypeNobody)
    {
#ifndef ARC_ENABLED
        NSBubbleDataInternal *dataInternal = [[[NSBubbleDataInternal alloc] init] autorelease];
#else
        NSBubbleDataInternal *dataInternal = [[NSBubbleDataInternal alloc] init];
#endif
        
        dataInternal.data = nil;
        dataInternal.type = NSBubbleDataTypeTypingBubble;
        dataInternal.labelSize = CGSizeMake(0, 0);
        dataInternal.height = 40;
        
        [self.bubbleDictionary setObject:[NSMutableArray arrayWithObject:dataInternal] forKey:[NSString stringWithFormat:@"%d", count]];
    }
    
    [super reloadData];
}

#pragma mark - UITableViewDelegate implementation

#pragma mark - UITableViewDataSource implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.bubbleDictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *keys = [self.bubbleDictionary allKeys];
	NSArray *sortedArray = [keys sortedArrayUsingComparator:^(id firstObject, id secondObject) {
		return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
	}];
    NSString *key = [sortedArray objectAtIndex:section];
    return [[self.bubbleDictionary objectForKey:key] count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *keys = [self.bubbleDictionary allKeys];
	NSArray *sortedArray = [keys sortedArrayUsingComparator:^(id firstObject, id secondObject) {
		return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
	}];
    NSString *key = [sortedArray objectAtIndex:indexPath.section];
    NSBubbleDataInternal *dataInternal = ((NSBubbleDataInternal *)[[self.bubbleDictionary objectForKey:key] objectAtIndex:indexPath.row]);

    return dataInternal.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *keys = [self.bubbleDictionary allKeys];
	NSArray *sortedArray = [keys sortedArrayUsingComparator:^(id firstObject, id secondObject) {
		return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
	}];
    NSString *key = [sortedArray objectAtIndex:indexPath.section];
    
    NSBubbleDataInternal *dataInternal = ((NSBubbleDataInternal *)[[self.bubbleDictionary objectForKey:key] objectAtIndex:indexPath.row]);
    
    if (dataInternal.type == NSBubbleDataTypeNormalBubble)
    {    
        static NSString *cellId = @"tblBubbleCell";
        UIBubbleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
        if (cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"UIBubbleTableViewCell" owner:self options:nil];
            cell = bubbleCell;
        }
    
        cell.dataInternal = dataInternal;
        return cell;
    }
    
    if (dataInternal.type == NSBubbleDataTypeTypingBubble)
    {
        static NSString *cellTypingId = @"tblBubbleTypingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTypingId];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImage *bubbleImage = nil;
            float x = 0;
            
            if (self.typingBubble == NSBubbleTypingTypeMe)
            {
                bubbleImage = [UIImage imageNamed:@"typingMine.png"]; 
                x = cell.frame.size.width - 4 - bubbleImage.size.width;
            }
            else
            {
                bubbleImage = [UIImage imageNamed:@"typingSomeone.png"]; 
                x = 4;
            }
            
            UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:bubbleImage];
            bubbleImageView.frame = CGRectMake(x, 4, 73, 31);
#ifndef ARC_ENABLED
            [cell addSubview:[bubbleImageView autorelease]];
#else
            [cell addSubview:bubbleImageView];
#endif
        }
        
        return cell;
    }
    
    return nil;
}

@end
