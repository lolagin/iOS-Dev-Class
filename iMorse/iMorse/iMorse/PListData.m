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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.path = [documentsDirectory stringByAppendingString:@"data.plist"];
    //self.path = [[NSBundle mainBundle] pathForResource:@"commonString" ofType:@"plist"];

}

@end
