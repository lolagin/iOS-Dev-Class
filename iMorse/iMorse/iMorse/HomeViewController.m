//
//  HomeViewController.m
//  iMorse
//
//  Created by Keith McClung on 5/18/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *sendButton;

@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"iMorse Home";
    
    [self addTextField];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sendButton setTitle:@"Send" forState:(UIControlStateNormal)];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton sizeToFit];
    self.sendButton.center = self.view.center;
    [self.sendButton addTarget:self action:@selector(parseString) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addTextField
{
    //allocates text field and sets its frame
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake( 20,250, 280, 30)];
    //sets border style fo textField and font size
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.textField setFont:[UIFont boldSystemFontOfSize:12]];
    //self.textField.textColor = [UIColor whiteColor];
    
    //test placeholder text
    self.textField.placeholder = @"This is a text field";
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.textField];
    self.textField.delegate = self;
}

#pragma mark - TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Text field did begin editing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Text field did end editing");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)parseString
{
    NSString *myString = self.textField.text;
    NSLog(myString);
}
@end
