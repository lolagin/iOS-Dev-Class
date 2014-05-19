//
//  HomeViewController.m
//  iMorse
//
//  Created by Keith McClung on 5/18/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import "HomeViewController.h"
#import "QuickChatTableViewController.h"

@interface HomeViewController ()
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *sendButton;
@property (nonatomic,strong) UIButton *favoritesButton;

@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"iMorse Home";
    
    [self addTextField];

    self.favoritesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.favoritesButton setTitle:@"Favorites" forState:(UIControlStateNormal)];
    [self.favoritesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.favoritesButton];
    [self.favoritesButton sizeToFit];
    self.favoritesButton.center = CGPointMake(52, 425);
    [self.favoritesButton addTarget:self action:@selector(favoriteSelector) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sendButton setTitle:@"Send" forState:(UIControlStateNormal)];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton sizeToFit];
    self.sendButton.center = CGPointMake(280, 425);
    [self.sendButton addTarget:self action:@selector(parseString) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addTextField
{
    //allocates text field and sets its frame
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake( 20,440, 280, 30)];
    //sets border style fo textField and font size
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.textField setFont:[UIFont boldSystemFontOfSize:12]];
    
    //test placeholder text
    self.textField.placeholder = @"Enter your message here.";
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.textField];
    self.textField.delegate = self;
}
//Animation for when the keyboard slides up
-(void)animateTextField: (UITextField*)textField up: (BOOL) up
{
    //distance of slide aka keyboard height
    const int movementDistance = 215;  //modify as needed
    const float movementDuration = 0.3f;  //modify as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    
}
#pragma mark - TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
    NSLog(@"Text field did begin editing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
    NSLog(@"Text field did end editing");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)favoriteSelector
{
    [self.navigationController pushViewController:[[QuickChatTableViewController alloc] init] animated:YES];

}
-(void)parseString
{
    NSString *myString = self.textField.text;
    NSLog(myString);
    self.textField.text = @"";
}
//This is called when the app goes into the background.
//We must reset the responder because animations will not be saved
- (void)appEnteredBackground
{
    [self.textField resignFirstResponder];
}
@end
