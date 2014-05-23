//
//  QuickChatTableViewController.h
//  iMorse
//
//  Created by Keith McClung on 5/18/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface QuickChatTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableArray *stringArray;

@property (nonatomic,weak) HomeViewController *controllerRef;



@end
