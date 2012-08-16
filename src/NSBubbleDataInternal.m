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

@implementation NSBubbleDataInternal

@synthesize data = _data;
@synthesize header = _header;
@synthesize height = _height;
@synthesize labelSize = _labelSize;

- (void)dealloc
{
	[_data release];
	_data = nil;
	[_header release];
	_header = nil;
    [super dealloc];
}

@end
