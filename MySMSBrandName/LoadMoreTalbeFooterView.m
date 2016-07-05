//
//  LoadMoreTalbeFooterView.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/26/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "LoadMoreTalbeFooterView.h"

#define FLIP_ANIMATION_DURATION 0.18f

@implementation LoadMoreTalbeFooterView

@synthesize delegate = _delegate;

-(id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor {
    
    if (self = [super initWithFrame:frame]) {
        
        CGRect footerRect = CGRectMake(0, frame.size.height - 20.0f, frame.size.width, 20.0f);
         UILabel *label = [[UILabel alloc] initWithFrame:footerRect];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = textColor;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        _statusLabel = label;
        
        [self addSubview:label];
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(frame.size.width/2 - 10, 0, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed:arrow].CGImage;
        
        //[[self layer] addSublayer:layer];
        _arrowImage = layer;
        
        
        [self setState:PullLoadMoreNormal];
        
        

    }
    
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame arrowImageName:@"blueArrowLoadMore.png" textColor:TEXT_COLOR];
}


- (void)setState:(PullLoadMoreState)aState{
    
    switch (aState) {
        case PullLoadMorePulling:
            
            _statusLabel.text = @"PullLoadMorePulling";
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        case PullLoadMoreNormal:
            
            if (_state == PullLoadMorePulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
         //   _statusLabel.text = @"PullLoadMoreNormal";
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            
            
            break;
            
        case PullLoadMoreLoading:
            
            _statusLabel.text = @"PullLoadMoreLoading";
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
        default:
            break;
    }
    
    _state = aState;
}


-(void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentSize.height == 0)
        return;
    
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height) {
        
        [self setState:PullLoadMorePulling];
        
        
        if ([_delegate respondsToSelector:@selector(loadMoreTableFooterDidTriggerLoadMore:)]) {
            
            [_delegate loadMoreTableFooterDidTriggerLoadMore:self];
        }
            
    } else {
        
        [self setState:PullLoadMoreNormal];
    }
}





@end
