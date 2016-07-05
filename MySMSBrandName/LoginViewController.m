//
//  LoginViewController.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/17/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "LoginViewController.h"
#import <RestKit/RestKit.h>
#import "Constant.h"
#import "SmsProgViewController.h"
#import "LoadingIndicatorViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


-(IBAction)loginBtnPressed:(id)sender;

@end

@implementation LoginViewController

@synthesize delegate = _delegate;

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        loadingIndicatorVC = [[LoadingIndicatorViewController alloc] init];
        loadingIndicatorVC.loginVC = self;
        
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self loginBtnPressed:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _statusLabel.hidden = true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginBtnPressed:(id)sender {
    
    
     [self.navigationController pushViewController:loadingIndicatorVC animated:TRUE];
    
    
    
    NSString *user = _userTextField.text;
    NSString *pass = _passTextField.text;
    BOOL isLoginSuccess = [self loginBrandName:user password:pass];
}



-(BOOL)loginBrandName:(NSString *)username password:(NSString *)password {
    
    __block BOOL isLoginSuccess = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) , ^{
        
        NSDictionary *queryParams = @{@"user_name" : username,
                                      @"password": password};
        
        [[RKObjectManager sharedManager] postObject:nil path:API_SIGNIN parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            _account  = mappingResult.firstObject;
            _statusLabel.hidden = false;
            
            //[NSThread sleepForTimeInterval:10];
            if (_account.errorCode == 0) {
                NSLog(@"Login thanh cong!!!");
                isLoginSuccess = YES;
                
                
                [_statusLabel setText:[NSString stringWithFormat:@"Token is %@", _account.token]];
                NSLog(@"Token is %@", _account.token);
        
                
            } else {
                
                isLoginSuccess = NO;
                [_statusLabel setText:[NSString stringWithFormat:@"Login failed caused by %@", _account.message]];
            }
            
            
            
            if ([_delegate respondsToSelector:@selector(didValidateLogin:token:)]) {
                
                [_delegate didValidateLogin:isLoginSuccess token:_account.token];
            }
            
            
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            NSLog(@"Error: Account not found %@", error);
        }];
        
            });
    
    return isLoginSuccess;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
