//
//  FirstTableViewController.m
//  table project
//
//  Created by Keith McClung on 5/14/14.
//  Copyright (c) 2014 Keith McClung. All rights reserved.
//

#import "FirstTableViewController.h"

@interface FirstTableViewController ()
@property (nonatomic,strong) NSArray *colorsArray;

@end

@implementation FirstTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorsArray = @[@"Red",@"Orange",@"Yellow", @"Green", @"Blue",@"Indigo", @"Violet"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.colorsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorIdentifier"];
    
    // Configure the cell...
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ColorIdentifier"];
    }
    cell.textLabel.text = self.colorsArray[indexPath.row];
    return cell;
}
@end
