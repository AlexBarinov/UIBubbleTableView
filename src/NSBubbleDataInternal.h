//
//  NSBubbleDataInternal.h
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

#import <Foundation/Foundation.h>

@class NSBubbleData;

typedef enum _NSBubbleDataType
{
    NSBubbleDataTypeNormalBubble = 0,
    NSBubbleDataTypeTypingBubble = 1
} NSBubbleDataType;

@interface NSBubbleDataInternal : NSObject

@property (nonatomic, strong) NSBubbleData* data;
@property (nonatomic) NSBubbleDataType type;
@property (nonatomic) float height;
@property (nonatomic) CGSize labelSize;
@property (nonatomic, strong) NSString *header;

@end
