//
//  FirstViewController.m
//  Day 3 No Storyboard
//
//  Created by Keith McClung on 5/9/14.
//  Copyright (c) 2014 Keith McClung. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdTableViewController.h"

@interface FirstViewController ()

@property (nonatomic,strong) UIButton *clickButton;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) NSArray *studentsArray;

@end

@implementation FirstViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"First";
    
    self.redView = [[UIView alloc] initWithFrame:CGRectZero];
    self.redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.redView];
    //self.redView = redView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Click Me!" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button sizeToFit];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonPushed) forControlEvents:UIControlEventTouchUpInside];
    self.clickButton = button;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.clickButton.center = self.view.center;
    CGFloat width;
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        width = 50;
    }
    else
    {
        width = 150;
    }
    self.redView.frame = CGRectMake(0,100,width,80);

}

-(void)buttonPushed
{
    [self.navigationController pushViewController:[[ThirdTableViewController alloc] init] animated:YES];
}

@end
