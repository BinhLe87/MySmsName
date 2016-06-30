//
//  SmsProgCell.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SmsProgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *progCodeLbl;

@property (weak, nonatomic) IBOutlet UILabel *progStatLbl;

@property (weak, nonatomic) IBOutlet UILabel *progAliasLbl;
@property (weak, nonatomic) IBOutlet UILabel *progCreatedDateLbl;

@end
