//
//  PListData.h
//  iMorse
//
//  Created by Keith McClung on 5/19/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PListData : NSObject
@property (nonatomic, strong) NSMutableArray *information;

-(void)getInformation;

@end
