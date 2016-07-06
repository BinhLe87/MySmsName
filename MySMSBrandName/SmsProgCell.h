//
//  SmsProgCell.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SmsProgCellDelegate;

@interface SmsProgCell : UITableViewCell

@property (nonatomic) id <SmsProgCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *progIDLbl;


@property (weak, nonatomic) IBOutlet UILabel *progCodeLbl;

@property (weak, nonatomic) IBOutlet UILabel *progStatLbl;

@property (weak, nonatomic) IBOutlet UILabel *progAliasLbl;
@property (weak, nonatomic) IBOutlet UILabel *progCreatedDateLbl;

@property (nonatomic, strong) UIView *swipeView;


-(IBAction)didSwipeLeftInCell:(id)sender;
-(void) setupSwipeGesture;

@end

@protocol SmsProgCellDelegate

-(void)didSwipeLeftInCellWithIndexPath:(NSIndexPath *)indexPath;

@end
