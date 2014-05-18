//
//  UIBubbleTableViewCell.m
//
//  Created by Alex Barinov
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//

#import <QuartzCore/QuartzCore.h>
#import "UIBubbleTableViewCell.h"
#import "NSBubbleData.h"
#import "ImageCache.h"

static NSInteger kCustomViewTag = 1234;

@interface UIBubbleTableViewCell ()

@property (nonatomic, retain) UIView *customView;
@property (nonatomic, retain) UIImageView *bubbleImage;
@property (nonatomic, retain) UIImageView *avatarImage;

- (void)adjustViewFrames;
- (void)createCustomViewHierarchy;

@end

@implementation UIBubbleTableViewCell

@synthesize data = _data;
@synthesize customView = _customView;
@synthesize bubbleImage = _bubbleImage;
@synthesize showAvatar = _showAvatar;
@synthesize avatarImage = _avatarImage;

#pragma mark - Accessors

- (void)setData:(NSBubbleData *)data {
#if !__has_feature(objc_arc)
    [data retain];
    [_data release];
    _data = data;
#else
    _data = data;
#endif

    // set content from data
    ImageCache *cache = [ImageCache sharedInstance];
    self.avatarImage.image = data.avatar ? data.avatar : [cache imageNamed:@"missingAvatar.png"];

    UIImage *image;
    if (data.type == BubbleTypeSomeoneElse) {
        image = [cache imageNamed:@"bubbleSomeone.png" stretchableWithLeftCapWidth:21 topCapHeight:14];
    }
    else {
        image = [cache imageNamed:@"bubbleMine.png" stretchableWithLeftCapWidth:21 topCapHeight:14];
    }
    self.bubbleImage.image = image;

    // update content view
    [[self.contentView viewWithTag:kCustomViewTag] removeFromSuperview];
    self.customView = data.view;
    self.customView.tag = kCustomViewTag;
    [self.contentView addSubview:self.customView];
}

- (UIView *)customView {
    if (!_customView) {
        _customView = [[UIView alloc] initWithFrame:CGRectZero];
        _customView.tag = kCustomViewTag;
    }
    return _customView;
}

- (UIImageView *)bubbleImage {
    if (!_bubbleImage) {
        _bubbleImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _bubbleImage;
}

- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImage.layer.cornerRadius = 9.0;
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
        _avatarImage.layer.borderWidth = 1.0;
    }
    return _avatarImage;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%s not implemented!", __PRETTY_FUNCTION__);
        //TODO ...
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCustomViewHierarchy];
    }
    return self;
}
- (void)createCustomViewHierarchy {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // create custom view hierarchy with no content
    [self.contentView addSubview:self.bubbleImage];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.customView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self adjustViewFrames];
}
- (void)adjustViewFrames {
    CGFloat width = self.data.view.frame.size.width;
    CGFloat height = self.data.view.frame.size.height;
    
    NSBubbleType type = self.data.type;
    CGFloat x = (type == BubbleTypeSomeoneElse) ? 0 : self.frame.size.width - width - self.data.insets.left - self.data.insets.right;
    CGFloat y = 0;
    
    // Adjusting the x coordinate for avatar
    if (self.showAvatar) {
        CGFloat avatarX = (type == BubbleTypeSomeoneElse) ? 2 : self.frame.size.width - 52;
        CGFloat avatarY = self.frame.size.height - 50;
        
        self.avatarImage.frame = CGRectMake(avatarX, avatarY, 50, 50);
        
        CGFloat delta = self.frame.size.height - (self.data.insets.top + self.data.insets.bottom + self.data.view.frame.size.height);
        if (delta > 0) y = delta;
        
        if (type == BubbleTypeSomeoneElse) x += 54;
        if (type == BubbleTypeMine) x -= 54;
    }
    
    self.customView.frame = CGRectMake(x + self.data.insets.left, y + self.data.insets.top, width, height);

    self.bubbleImage.frame = CGRectMake(x, y, width + self.data.insets.left + self.data.insets.right, height + self.data.insets.top + self.data.insets.bottom);
}

#if !__has_feature(objc_arc)
- (void) dealloc
{
    [_data release];
    [_customView release];
    [_bubbleImage release];
    [_avatarImage release];
    _data = nil;
    _customView = nil;
    _bubbleImage = nil;
    _avatarImage = nil;
    [super dealloc];
}
#endif

@end
