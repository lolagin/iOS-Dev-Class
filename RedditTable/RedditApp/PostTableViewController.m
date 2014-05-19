//
//  PostTableViewController.m
//  RedditApp
//
//  Created by Keith McClung on 5/16/14.
//  Copyright (c) 2014 Keith McClung. All rights reserved.
//

#import "PostTableViewController.h"
#import "RedditPost.h"

@interface PostTableViewController ()
@property (nonatomic,strong) NSArray *postArray;

@end

@implementation PostTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Reddit Posts";
    
    
    [self refresh];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)refresh
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://reddit.com/.json"]];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *array = [dictionary valueForKeyPath:@"data.children"];
        
        NSMutableArray *mutArray = [NSMutableArray array];
        
        for(NSDictionary *postDict in array)
        {
            RedditPost *newPost = [[RedditPost alloc]init];
            newPost.title = [postDict valueForKeyPath:@"data.title"];
            [mutArray addObject:newPost];
        }
        
        self.postArray = [NSArray arrayWithArray:mutArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        NSLog(@"It's Done");
    }];
    
    [task resume];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.postArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postIdentifier"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"postIdentifier"];
    }
    //configure the cell properly
    RedditPost *post = self.postArray[indexPath.row];
    
    
    cell.textLabel.text = post.title;
    
    
    return cell;
}



@end
