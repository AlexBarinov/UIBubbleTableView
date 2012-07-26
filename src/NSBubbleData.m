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

@synthesize date;
@synthesize type;
@synthesize text;

+ (id)dataWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type
{
    return [[[NSBubbleData alloc] initWithText:text andDate:date andType:type] autorelease];
}

- (id)initWithText:(NSString *)initText andDate:(NSDate *)initDate andType:(NSBubbleType)initType
{
    self = [super init];
    if (self)
    {
        self.text = initText;
        self.date = initDate;
        self.type = initType;        
    }
    return self;
}

@end
