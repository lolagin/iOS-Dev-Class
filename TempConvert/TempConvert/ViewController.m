//
//  ViewController.m
//  TempConvert
//
//  Created by Keith McClung on 5/23/14.
//  Copyright (c) 2014 Keith McClung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cTextField;
@property (weak, nonatomic) IBOutlet UITextField *fTextField;
@property (weak, nonatomic) IBOutlet UITextField *kTextField;
@property (nonatomic) float fValue;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)textFieldChange:(id)sender
{
    UITextField *theCorrectField = nil;
    
    if([sender isKindOfClass:[UITextField class]])
    {
        theCorrectField = (UITextField *)sender;
    }
    
    float fahValue = [theCorrectField.text floatValue];
    
    if(sender == self.cTextField)
    {
        fahValue = (fahValue * 1.8) + 32;
    }
    else if(sender == self.kTextField)
    {
        fahValue = ((fahValue-273.15) *1.8) + 32;
    }
    
    self.fValue = fahValue;
    
}
/*-(IBAction)cTextFieldChange:(id)sender
{
    float celsiusValue = [self.cTextField.text floatValue];
    self.fValue = (celsiusValue * 1.8) + 32;
}
-(IBAction)fTextFieldChange:(id)sender
{
    self.fValue = [self.fTextField.text floatValue];
}
-(IBAction)kTextFieldChange:(id)sender
{
    float kelvinValue = [self.kTextField.text floatValue];
    self.fValue = ((kelvinValue-273.15) *1.8) + 32;
}*/
-(void)setFValue:(float)fValue
{
    _fValue = fValue;
    
    if(![self.fTextField isFirstResponder])
    {
        self.fTextField.text = [NSString stringWithFormat:@"%.2f",_fValue];
    }
    if(![self.cTextField isFirstResponder])
    {
        self.cTextField.text = [NSString stringWithFormat:@"%.2f",(_fValue-32)/1.8];
    }
    if(![self.kTextField isFirstResponder])
    {
        self.kTextField.text = [NSString stringWithFormat:@"%.2f",((_fValue-21)/1.8)+273.15];
    }
}
@end
