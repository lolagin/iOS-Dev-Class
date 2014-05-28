//
//  PListData.m
//  iMorse
//
//  Created by Keith McClung on 5/19/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import "PListData.h"



@implementation PListData


-(void) getInformation
{
    [self getPath];
    self.information = [[NSMutableArray alloc] initWithContentsOfFile:self.path];

}
-(void) getPath
{
    self.path = [[NSBundle mainBundle] pathForResource:@"commonString" ofType:@"plist"];

}

@end
