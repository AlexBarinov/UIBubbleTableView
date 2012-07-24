//
//  NSBubbleDataInternal.h
//  UIBubbleTableViewExample
//
//  Created by Alex Barinov on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSBubbleData;

@interface NSBubbleDataInternal : NSObject

@property (nonatomic, strong) NSBubbleData* data;
@property (nonatomic) float height;
@property (nonatomic) CGSize labelSize;
@property (nonatomic, strong) NSString *header;

@end
