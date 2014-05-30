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
@property (nonatomic,strong) UIButton *sendButton;
@property (nonatomic,strong) UIButton *favoritesButton;
@property (nonatomic,strong) NSDictionary *morseDict;
@property (nonatomic,strong) AVCaptureDevice *cameraFlash;

@end

@implementation HomeViewController

double timeUnit = 0.3;

@synthesize torchSession;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blackColor];
    self.title = @"iMorse Home";
    //calls textField
    [self addTextField];
    
    //creates button for "dot" signal
    UIButton *dotButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 100, 100)];
    [dotButton setBackgroundImage:[UIImage imageNamed:@"dot.png"] forState:UIControlStateNormal];
    [dotButton addTarget:self action:@selector(dotBlink) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:dotButton];
    
    //creates button for "dash" signal
    UIButton *dashButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 150, 100, 100)];
    [dashButton setBackgroundImage:[UIImage imageNamed:@"dash.png"] forState:UIControlStateNormal];
    [dashButton addTarget:self action:@selector(dashBlink) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:dashButton];

    //creates button for favorites menu
    self.favoritesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.favoritesButton setTitle:@"Favorites" forState:(UIControlStateNormal)];
    //[self.favoritesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.favoritesButton];
    [self.favoritesButton sizeToFit];
    self.favoritesButton.center = CGPointMake(52, 315);
    [self.favoritesButton addTarget:self action:@selector(favoriteSelector) forControlEvents:UIControlEventTouchUpInside];
    
    //creates button that sends the typed message
    self.sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sendButton setTitle:@"Send" forState:(UIControlStateNormal)];
    //[self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton sizeToFit];
    self.sendButton.center = CGPointMake(280, 315);
    [self.sendButton addTarget:self action:@selector(parseString) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *keyArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@" "];
    
    NSArray *morseArray =@[@".-",@"-...",@"-.-.",@"-..",@".",@"..-.",@"--.",@"....",@"..",@".---",@"-.-",@".-..",@"--",@"-.",@"---",@".--.",@"--.-",@".-.",@"...",@"-",@"..-",@"...-",@".--",@"-..-",@"-.--",@"--..",@"0"];
    //dictionary that holds the conversion from english to morse
    self.morseDict = [NSDictionary dictionaryWithObjects:morseArray forKeys:keyArray];
}

-(void)addTextField
{
    //allocates text field and sets its frame
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake( 20,330, 280, 30)];
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
    const int movementDistance = 100;  //modify as needed
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
    //NSLog(@"Text field did begin editing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
    //NSLog(@"Text field did end editing");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//pushes to favorites view, uses favorite button
-(void)favoriteSelector
{
    QuickChatTableViewController *favoriteView = [[QuickChatTableViewController alloc] init];
    favoriteView.controllerRef = self;
    [self.navigationController pushViewController:favoriteView animated:YES];

}
//begins parsing string into single characters
-(void)parseString
{
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue", NULL);
    dispatch_async(myQueue, ^{
        
        NSString *myString = self.textField.text;
    
        for(int i = 0; i<myString.length;i++)
        {
            NSString *singleChar = [myString substringWithRange:NSMakeRange(i,1)];
            NSString *morseChar = [self.morseDict objectForKey:[singleChar uppercaseString]];
            [self parseMorse:morseChar];
        
            NSLog(@"Morse Signal for %@ is %@",singleChar,[self.morseDict objectForKey:[singleChar uppercaseString]]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        
        });
    });
}
//parses each morse signal into the proper flashes
-(void)parseMorse: (NSString *)morseString
{
    //NSTimer *delay;
    for(int i=0; i<morseString.length;i++)
    {
        if([[morseString substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"-"])
        {
            NSLog(@"Sent dash");
            
            [NSThread sleepForTimeInterval:timeUnit];
            [self flashOn:[NSNumber numberWithInt:3]];
            //[self performSelector:@selector(flashOn:) withObject:[NSNumber numberWithInt:3] afterDelay:timeUnit];
            //delay = [NSTimer scheduledTimerWithTimeInterval:timeUnit target:self selector:@selector(flashOff) userInfo:nil repeats:NO];
        }
        else if([[morseString substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"."])
        {
            NSLog(@"Sent dot");
            [NSThread sleepForTimeInterval:timeUnit];
            [self flashOn:[NSNumber numberWithInt:1]];
            //[self performSelector:@selector(flashOn:) withObject:[NSNumber numberWithInt:1] afterDelay:timeUnit];
            //delay = [NSTimer scheduledTimerWithTimeInterval:timeUnit target:self selector:@selector(flashOff) userInfo:nil repeats:NO];
        }
        else
        {
            NSLog(@"Sent Space");
            [NSThread sleepForTimeInterval:timeUnit*4];
            //[self performSelector:@selector(doNothing) withObject:nil afterDelay:(timeUnit*4)];
            //delay = [NSTimer scheduledTimerWithTimeInterval:(timeUnit*4) target:self selector:@selector(doNothing) userInfo:nil repeats:NO];
        }

        
    }
}
//forces single flash for "dash" signal
-(void)dashBlink
{
    [self flashOn:[NSNumber numberWithInteger:3]];
}
//forces single flash for "dot" signal
-(void)dotBlink
{
    [self flashOn:[NSNumber numberWithInteger:1]];
}
//turns on flash and then stalls for how long the signal should be
-(void)flashOn: (NSNumber *)_flashLength
{
    int flashLength = [_flashLength intValue];
    //NSTimer *flashTime;
    
    self.cameraFlash = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSLog(@"Entered FlashOn");
    
    //only enteres if there is a camera with a flash
    if([self.cameraFlash hasTorch]&&[self.cameraFlash hasFlash])
    {
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.cameraFlash error:nil];
        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
        
        [session addInput:input];
        [session addOutput:output];
        
        [session beginConfiguration];
        
        [self.cameraFlash lockForConfiguration:nil];
        
        [self.cameraFlash setTorchMode:AVCaptureTorchModeOn];
        
        [session commitConfiguration];
        [session startRunning];
        
        [self setTorchSession:session];
        
        [NSThread sleepForTimeInterval:timeUnit*flashLength];
        //[self performSelector:@selector(flashOff) withObject:self afterDelay:(timeUnit*flashLength)];
        //flashTime = [NSTimer scheduledTimerWithTimeInterval:(timeUnit*flashLength) target:self selector:@selector(flashOff) userInfo:nil repeats:NO];
        NSLog(@"Flash On for %d units",flashLength);
        
    }
}
//turns off the flash
-(void)flashOff
{
    [self.cameraFlash setTorchMode:AVCaptureTorchModeOff];
    [self.cameraFlash unlockForConfiguration];
    [torchSession stopRunning];
    NSLog(@"Flash OFf");
}
//end of space pause
-(void)doNothing
{
    NSLog(@"pause for space has ended");
}
//This is called when the app goes into the background.
//We must reset the responder because animations will not be saved
- (void)appEnteredBackground
{
    [self.textField resignFirstResponder];
}
@end
