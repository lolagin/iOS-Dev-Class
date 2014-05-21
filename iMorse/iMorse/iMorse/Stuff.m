//
//  stuf.m
//  iMorse
//
//  Created by Keith McClung on 5/19/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import "Stuff.h"

@implementation stuf

-(void) getStuff
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"commonString" ofType:@"plist"];
    
    self.stuff = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    
}
@end
