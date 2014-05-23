//
//  HomeViewController.h
//  iMorse
//
//  Created by Keith McClung on 5/18/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface HomeViewController : UIViewController<UITextFieldDelegate>
{
    AVCaptureSession *torchSession;
}
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) AVCaptureSession *torchSession;


@end
