//
//  UIBubbleTableViewCell.m
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


#import "UIBubbleTableViewCell.h"
#import "NSBubbleData.h"

@interface UIBubbleTableViewCell ()
- (void) setupInternalData;
@end

@implementation UIBubbleTableViewCell

@synthesize dataInternal = _dataInternal;
@synthesize avatarImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UINib *aXib = [UINib nibWithNibName:@"UIBubbleTableViewCell" bundle:[NSBundle mainBundle]];
        UIView *aView = [[aXib instantiateWithOwner:self options:nil] lastObject];
        aView.frame = self.frame;
        [self addSubview:aView];
    }

    return self;
}

-(void) setWidth:(NSInteger)aWidth
{
    [self setFrame:CGRectMake(self.frame.origin.x,
                              self.frame.origin.y,
                              aWidth,
                              self.frame.size.height)];
}

-(void) setCustomBubbleFont:(UIFont *)aFont;
{
    contentLabel.font = aFont;
    headerLabel.font = aFont;
}

-(void) awakeFromNib
{
    [super awakeFromNib];
    //Customize IBOutlets here
    
    //Default values
    UIFont *defaultFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];

    contentLabel.font = defaultFont;
    headerLabel.font = defaultFont;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
	[self setupInternalData];
}

- (void) dealloc
{
    [_dataInternal release];
	_dataInternal = nil;
    [avatarImage release];
    [super dealloc];
}


- (void)setDataInternal:(NSBubbleDataInternal *)value
{
	[value retain];
	[_dataInternal release];
	_dataInternal = value;
	[self setupInternalData];
}

- (void) setupInternalData
{
    if (self.dataInternal.header)
    {
        headerLabel.hidden = NO;
        headerLabel.text = self.dataInternal.header;
    }
    else
    {
        headerLabel.hidden = YES;
    }
        
    NSBubbleType type = self.dataInternal.data.type;
    
    float x = (type == BubbleTypeSomeoneElse) ? 20 : self.frame.size.width - 20 - self.dataInternal.labelSize.width;
    float y = 5 + (self.dataInternal.header ? 30 : 0);
    
    
    if (self.dataInternal.data.avatar && type == BubbleTypeSomeoneElse) {
        [avatarImage setImage:self.dataInternal.data.avatar];
        x += avatarImage.frame.size.width + 5;
    } else {
        [avatarImage setImage:nil];
    }

    contentLabel.frame = CGRectMake(x, y, self.dataInternal.labelSize.width, self.dataInternal.labelSize.height);
    contentLabel.text = self.dataInternal.data.text;
    
    if (type == BubbleTypeSomeoneElse)
    {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleSomeone.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 18, y - 4, self.dataInternal.labelSize.width + 30, self.dataInternal.labelSize.height + 15);
    }
    else {
        bubbleImage.image = [[UIImage imageNamed:@"bubbleMine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
        bubbleImage.frame = CGRectMake(x - 9, y - 4, self.dataInternal.labelSize.width + 26, self.dataInternal.labelSize.height + 15);
    }
}

@end
