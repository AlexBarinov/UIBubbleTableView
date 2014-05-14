//
//  ImageCache.h
//  InstrumentsTutorial
//
//  Created by Matt Galloway on 06/09/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//  Modified by Lubos Ilcik on 14/05/2014.
//

#import <Foundation/Foundation.h>

typedef void(^ImageCacheDownloadCompletionHandler)(UIImage *image);

@interface ImageCache : NSObject

+ (id)sharedInstance;

- (UIImage*)imageForKey:(NSString*)key;
- (void)setImage:(UIImage*)image forKey:(NSString*)key;
- (void)downloadImageAtURL:(NSURL*)url completionHandler:(ImageCacheDownloadCompletionHandler)completion;
- (UIImage*)imageNamed:(NSString*)name;
- (UIImage *)imageNamed:(NSString*)name stretchableWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

@end
