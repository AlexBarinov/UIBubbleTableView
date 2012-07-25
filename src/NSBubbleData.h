//
//  NSBubbleData.h
//
//  Created by Alex Barinov
//  StexGroup, LLC
//  http://www.stexgroup.com
//

#import <Foundation/Foundation.h>

typedef enum _NSBubbleType
{
    BubbleTypeMine = 0,
    BubbleTypeSomeoneElse = 1
} NSBubbleType;

@interface NSBubbleData : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSBubbleType type;
@property (nonatomic, strong) NSString *text;

- (id)initWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type;
+ (id)dataWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type;

@end
