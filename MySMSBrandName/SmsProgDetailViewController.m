//
//  SmsProgDetailViewController.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/22/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "SmsProgDetailViewController.h"

@interface SmsProgDetailViewController ()

@end

@implementation SmsProgDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.progIDTxt.text = _smsProgEntity.prog_id;
    self.progCodeTxt.text = _smsProgEntity.prog_code;
    self.contentTxt.text = _smsProgEntity.content;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
