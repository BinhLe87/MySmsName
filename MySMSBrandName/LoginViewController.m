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


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


-(IBAction)loginBtnPressed:(id)sender;

@end

@implementation LoginViewController

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
    
    NSString *user = _userTextField.text;
    NSString *pass = _passTextField.text;
    
    NSDictionary *queryParams = @{@"user_name" : user,
                                  @"password": pass};
    
    
    [[RKObjectManager sharedManager] postObject:nil path:API_SIGNIN parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        _account  = mappingResult.firstObject;
        
           NSLog(@"Login thanh cong!!!");
        
        _statusLabel.hidden = false;
        
        [_statusLabel setText:[NSString stringWithFormat:@"Token is %@", _account.token]];
        NSLog(@"Token is %@", _account.token);
       
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error: Account not found %@", error);
    }];

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
