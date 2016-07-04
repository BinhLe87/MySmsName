//
//  LoadingIndicatorViewController.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 7/2/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "LoadingIndicatorViewController.h"
#import "LoginViewController.h"

@interface LoadingIndicatorViewController ()

@end

@implementation LoadingIndicatorViewController

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        smsProgVC = [[SmsProgViewController alloc] init];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _loginVC.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor blueColor]];
    CGFloat width = self.view.bounds.size.width / 4.0f;
    CGFloat height = self.view.bounds.size.height / 6.0f;
    
    activityIndicatorView.frame = CGRectMake((self.view.frame.size.width - width)/2.0, (self.view.frame.size.height-height)/2.0, width, height);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didValidateLogin:(BOOL)isLoginSuccess token:(NSString *)token {
    
    if (!isLoginSuccess) {
        
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    } else {
        
        smsProgVC.token = token;        
        [self.navigationController pushViewController:smsProgVC animated:TRUE];
    }
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
