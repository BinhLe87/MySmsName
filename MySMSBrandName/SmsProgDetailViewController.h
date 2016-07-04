//
//  SmsProgDetailViewController.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/22/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsProg.h"


@interface SmsProgDetailViewController : UIViewController {
    
 
}


@property (weak, nonatomic) IBOutlet UITextField *progIDTxt;

@property (weak, nonatomic) IBOutlet UITextField *progCodeTxt;


@property (weak, nonatomic) IBOutlet UITextField *contentTxt;

@property (nonatomic) smsProg *smsProgEntity;

@end
