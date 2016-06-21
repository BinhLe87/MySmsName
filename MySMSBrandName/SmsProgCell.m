//
//  SmsProgCell.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "SmsProgCell.h"

@interface SmsProgCell()
@property (weak, nonatomic) IBOutlet UILabel *progCodeLbl;

@property (weak, nonatomic) IBOutlet UILabel *progStatLbl;

@property (weak, nonatomic) IBOutlet UILabel *progAliasLbl;
@property (weak, nonatomic) IBOutlet UILabel *progCreatedDateLbl;

@end

@implementation SmsProgCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end