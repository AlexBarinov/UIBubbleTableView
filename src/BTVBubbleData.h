//
//  NSBubbleData.h
//
//  Created by Alex Barinov
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//

#import <Foundation/Foundation.h>

typedef enum _BTVBubbleType
{
    BubbleTypeMine = 0,
    BubbleTypeSomeoneElse = 1,
    BubbleTypeInfo = 2
} BTVBubbleType;

@interface BTVBubbleData : NSObject

@property (readonly, nonatomic, strong) NSDate *date;
@property (readonly, nonatomic) BTVBubbleType type;
@property (readonly, nonatomic, strong) UIView *view;
@property (readonly, nonatomic) UIEdgeInsets insets;
@property (nonatomic, strong) UIImage *avatar;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *userLabel;

- (id)initWithText:(NSString *)text date:(NSDate *)date type:(BTVBubbleType)type;
+ (id)dataWithText:(NSString *)text date:(NSDate *)date type:(BTVBubbleType)type;
- (id)initWithImage:(UIImage *)image date:(NSDate *)date type:(BTVBubbleType)type;
+ (id)dataWithImage:(UIImage *)image date:(NSDate *)date type:(BTVBubbleType)type;
- (id)initWithView:(UIView *)view date:(NSDate *)date type:(BTVBubbleType)type insets:(UIEdgeInsets)insets;
+ (id)dataWithView:(UIView *)view date:(NSDate *)date type:(BTVBubbleType)type insets:(UIEdgeInsets)insets;

@end
