//
//  NSBubbleData.m
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

#import "NSBubbleData.h"

@implementation NSBubbleData

@synthesize date = _date;
@synthesize type = _type;
@synthesize text = _text;
@synthesize view = _view;

+ (id)dataWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type
{
    return [[[NSBubbleData alloc] initWithText:text andDate:date andType:type] autorelease];
}

- (id)initWithText:(NSString *)initText andDate:(NSDate *)initDate andType:(NSBubbleType)initType
{
    self = [super init];
    if (self)
    {
        _text = [initText retain];
        if (!_text || [_text isEqualToString:@""]) _text = @" ";
        
        _date = [initDate retain];
        _type = initType;
    }
    return self;
}

+ (id)dataWithView:(UIView *)view andDate:(NSDate *)date andType:(NSBubbleType)type
{
    return [[[NSBubbleData alloc] initWithView:view andDate:date andType:type] autorelease];
}

- (id)initWithView:(UIView *)view andDate:(NSDate *)date andType:(NSBubbleType)type
{
    self = [super init];
    if (self) {
        _view = [view retain];
        _date = [date retain];
        _type = type;
    }
    return self;
}

- (void)dealloc
{
    [_date release];
	_date = nil;
	[_text release];
	_text = nil;
    [_view release];
    _view = nil;
    [super dealloc];
}

@end
