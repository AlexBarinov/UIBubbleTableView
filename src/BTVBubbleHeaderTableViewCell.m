//
//  UIBubbleHeaderTableViewCell.m
//  UIBubbleTableViewExample
//
//  Created by Александр Баринов on 10/7/12.
//  Copyright (c) 2012 Stex Group. All rights reserved.
//

#import "BTVBubbleHeaderTableViewCell.h"

@interface BTVBubbleHeaderTableViewCell ()

@property (nonatomic, retain) UILabel *label;

@end

@implementation BTVBubbleHeaderTableViewCell

@synthesize label = _label;
@synthesize date = _date;

+ (CGFloat)height
{
    return 28.0;
}

- (void)setDate:(NSDate *)value
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *text = [dateFormatter stringFromDate:value];
    [dateFormatter release];
    
    if(!self.label)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [BTVBubbleHeaderTableViewCell height])] autorelease];
        self.label.font = [UIFont boldSystemFontOfSize:12];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.shadowOffset = CGSizeMake(0, 1);
        self.label.shadowColor = [UIColor whiteColor];
        self.label.textColor = [UIColor darkGrayColor];
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];        
    }
    
    self.label.text = text;
}

-(void)setInfo:(NSString *)info
{
    if(!self.label)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [BTVBubbleHeaderTableViewCell height])] autorelease];
        self.label.font = [UIFont boldSystemFontOfSize:12];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.shadowOffset = CGSizeMake(0, 1);
        self.label.shadowColor = [UIColor whiteColor];
        self.label.textColor = [UIColor darkGrayColor];
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
    }
    self.label.text = info;
    _info = info;
}


@end
