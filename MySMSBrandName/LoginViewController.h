//
//  LoginViewController.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/17/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDAO.h"



@class LoadingIndicatorViewController;
@protocol LoginDelegate;

@interface LoginViewController : UIViewController {
    
    LoadingIndicatorViewController *loadingIndicatorVC;
    id _delegate;
}

@property (nonatomic, strong) UserDAO *account;
@property (nonatomic) id <LoginDelegate> delegate;


-(BOOL)loginBrandName:(NSString*)username password:(NSString*)password;

@end


@protocol LoginDelegate

-(void) didValidateLogin:(BOOL)isLoginSuccess token:(NSString*)token;

@end
