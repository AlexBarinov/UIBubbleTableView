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
@synthesize avatar = _avatar;

+ (id)dataWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type andAvatar:(UIImage *)avatar
{
#ifndef ARC_ENABLED
    return [[[NSBubbleData alloc] initWithText:text andDate:date andType:type andAvatar:avatar] autorelease];
#else
    return [[NSBubbleData alloc] initWithText:text andDate:date andType:type andAvatar:avatar];
#endif     
}

+ (id)dataWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type
{
    return [self dataWithText:text andDate:date andType:type andAvatar:nil];
}

- (id)initWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type
{
    return [self initWithText:text andDate:date andType:type andAvatar:nil];
}

- (id)initWithText:(NSString *)initText andDate:(NSDate *)initDate andType:(NSBubbleType)initType andAvatar:(UIImage*)initAvatar
{
    self = [super init];
    if (self)
    {
#ifndef ARC_ENABLED
        _text = [initText retain];
        _date = [initDate retain];
        _avatar = [initAvatar retain];
#else
        _text = initText;
        _date = initDate;
        _avatar = initAvatar;
#endif

        if (!_text || [_text isEqualToString:@""]) _text = @" ";
        
        _type = initType;
    }
    return self;
}

#ifndef ARC_ENABLED
- (void)dealloc
{
    [_date release];
	[_text release];
    [_avatar release];
	_date = nil;
	_text = nil;
    _avatar = nil;
    [super dealloc];
}
#endif

@end
