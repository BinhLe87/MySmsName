//
//  SmsProgCell.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "SmsProgCell.h"

@interface SmsProgCell()


@end

@implementation SmsProgCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupSwipeGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse {
    
    [self setupSwipeGesture];
}



-(void)setupSwipeGesture{
    
    // Create the top view
    _swipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 80)];
    [_swipeView setBackgroundColor:[UIColor darkGrayColor]];
    
    // Create the swipe label
    UILabel *haveSwipedlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 30)];
    [haveSwipedlabel setFont:[UIFont fontWithName:@"GillSans-Bold" size:18]];
    [haveSwipedlabel setTextColor:[UIColor whiteColor]];
    [haveSwipedlabel setBackgroundColor:[UIColor darkGrayColor]];
    [haveSwipedlabel setText:@"I've been swiped!"];
    [_swipeView addSubview:haveSwipedlabel];
    
    // Add views to contentView
    [self.contentView addSubview:_swipeView];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeftInCell:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeft];
    
    // Prevent selection highlighting
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

}

-(void)didSwipeLeftInCell:(id)sender {
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:1.0 animations:^{
        
        [self.contentView setFrame:CGRectMake(-10, 0, 320, 80)];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            [self.contentView setFrame:CGRectMake(0, 0, 320, 80)];
        }];
    }];
    
    
}

@end
