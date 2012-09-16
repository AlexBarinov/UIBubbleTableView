//
//  NSBubbleDataInternal.m
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

#import "NSBubbleDataInternal.h"
#import "NSBubbleData.h"

@implementation NSBubbleDataInternal

@synthesize data = _data;
@synthesize type = _type;
@synthesize header = _header;
@synthesize height = _height;
@synthesize labelSize = _labelSize;

#ifndef ARC_ENABLED
- (void)dealloc
{
	[_data release];
	[_header release];
	_data = nil;
	_header = nil;
    [super dealloc];
}
#endif

@end
