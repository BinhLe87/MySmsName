//
//  SmsProgCell.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SmsProgCellDelegate;

@interface SmsProgCell : UITableViewCell {
    
    id _delegate;
    UILongPressGestureRecognizer *lgGesture;
}

@property (nonatomic) id <SmsProgCellDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *progIDLbl;


@property (weak, nonatomic) IBOutlet UILabel *progCodeLbl;

@property (weak, nonatomic) IBOutlet UILabel *progStatLbl;

@property (weak, nonatomic) IBOutlet UILabel *progAliasLbl;
@property (weak, nonatomic) IBOutlet UILabel *progCreatedDateLbl;

@property (nonatomic, strong) UIView *swipeView;

@property (weak, nonatomic) IBOutlet UIView *topView;


-(IBAction)didSwipeLeftInCell:(id)sender;
-(IBAction)didResetSwipeLeftInCell;
-(void) willEnableGesture;
-(void) willDisableGesture;
-(void) setupSwipeGesture;

@end

@protocol SmsProgCellDelegate

-(void)didSwipeLeftInCellWithIndexPath:(NSIndexPath *)indexPath;

@end
