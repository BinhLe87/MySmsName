//
//  LoadingIndicatorViewController.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 7/2/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"
#import "LoginViewController.h"
#import "SmsProgViewController.h"


@class LoginViewController;

@interface LoadingIndicatorViewController : UIViewController <LoginDelegate>{
    
    DGActivityIndicatorView *activityIndicatorView;
    SmsProgViewController *smsProgVC;
}

@property (nonatomic) LoginViewController *loginVC;



@end
