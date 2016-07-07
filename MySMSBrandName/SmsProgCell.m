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


@synthesize delegate = _delegate;

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
    _swipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [_swipeView setBackgroundColor:[UIColor grayColor]];
    
    // Create the swipe label
    UILabel *haveSwipedlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 30)];
    [haveSwipedlabel setFont:[UIFont fontWithName:@"GillSans-Bold" size:18]];
    [haveSwipedlabel setTextColor:[UIColor whiteColor]];
    [haveSwipedlabel setBackgroundColor:[UIColor grayColor]];
    [haveSwipedlabel setText:@"I've been swiped!"];
    [_swipeView addSubview:haveSwipedlabel];
    
    // Add views to contentView
    [self.contentView addSubview:_swipeView];
    [self.contentView addSubview:_topView];
    
    if (lgGesture == nil) {
        lgGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeftInCell:)];
        lgGesture.minimumPressDuration = 1;
    }
    
    
    [self addGestureRecognizer:lgGesture];
    
    // Prevent selection highlighting
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.swipeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willEnableGesture)
                                                 name:@"EnableGestureOnCell"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willDisableGesture)
                                                 name:@"DisableGestureOnCell"
                                               object:nil];
}

-(void)didSwipeLeftInCell:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didSwipeLeftInCellWithIndexPath:)]) {
        
        [_delegate didSwipeLeftInCellWithIndexPath:_indexPath];
    }
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:1.0 animations:^{
        
        [self.topView setFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
           [UIView animateWithDuration:0.15 animations:^{
            [self.swipeView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        } ];
    }];
}

- (void)didResetSwipeLeftInCell {
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.1 animations:^{
        
        [self.swipeView setFrame:CGRectMake(-self.contentView.frame.size.width, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.15 animations:^{
            [self.topView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        } ];
    }];
}

-(void)willEnableGesture {
    
    lgGesture.enabled = YES;
}

-(void)willDisableGesture {
    
    lgGesture.enabled = NO;
}

@end
