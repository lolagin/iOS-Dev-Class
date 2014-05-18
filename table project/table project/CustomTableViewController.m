//
//  CustomTableViewController.m
//  table project
//
//  Created by Keith McClung on 5/14/14.
//  Copyright (c) 2014 Keith McClung. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *colorsArray;


@end

@implementation CustomTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorsArray = @[@"Red",@"Orange",@"Yellow", @"Green", @"Blue",@"Indigo", @"Violet"];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.title = @"Custom View";
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    //self.tableView.frame = self.view.bounds;
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height/2);
    //self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    
}

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
