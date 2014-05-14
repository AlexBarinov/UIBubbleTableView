//
//  ImageCache.m
//  InstrumentsTutorial
//
//  Created by Matt Galloway on 06/09/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//  Modified by Lubos Ilcik on 14/05/2014.
//

#import "ImageCache.h"

@interface ImageCache () {
    NSMutableDictionary *_cache;
}
@end

@implementation ImageCache

+ (id)sharedInstance {
    static ImageCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        _cache = [NSMutableDictionary new];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (UIImage*)imageForKey:(NSString*)key {
    return [_cache objectForKey:key];
}

- (void)setImage:(UIImage*)image forKey:(NSString*)key {
    [_cache setObject:image forKey:key];
}

- (void)downloadImageAtURL:(NSURL*)url completionHandler:(ImageCacheDownloadCompletionHandler)completion {
    UIImage *cachedImage = [self imageForKey:[url absoluteString]];
    if (cachedImage) {
        completion(cachedImage);
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            [self setImage:image forKey:[url absoluteString]];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        });
    }
}

- (UIImage*)imageNamed:(NSString*)name {
    UIImage *image;
    if (!(image = [self imageForKey:name])) {
        image = [UIImage imageNamed:name];
        [self setImage:image forKey:name];
    }
    return image;
}

- (UIImage *)imageNamed:(NSString*)name stretchableWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    UIImage *image;
    if (!(image = [self imageForKey:name])) {
        image = [[UIImage imageNamed:name] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        [self setImage:image forKey:name];
    }
    return image;
}

#pragma mark - Private

- (void)memoryWarning:(NSNotification*)note {
    [_cache removeAllObjects];
}

@end
