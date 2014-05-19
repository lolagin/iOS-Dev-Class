//
//  RedditPost.h
//  RedditApp
//
//  Created by Keith McClung on 5/16/14.
//  Copyright (c) 2014 Keith McClung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedditPost : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSURL *imageURL;

@end
