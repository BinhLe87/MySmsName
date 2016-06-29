//
//  LoadMoreTalbeFooterView.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/26/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PullLoadMoreNormal,
    PullLoadMorePulling,
    PullLoadMoreLoading,
} PullLoadMoreState;


@protocol LoadMoreTableFooterDelegate;

@interface LoadMoreTalbeFooterView : UIView {
    
    PullLoadMoreState _state;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    __unsafe_unretained id _delegate;
}


@property(nonatomic,assign) id <LoadMoreTableFooterDelegate> delegate;

-(id) initWithFrame:(CGRect)frame arrowImageName:(NSString*)arrow textColor:(UIColor*)textColor;
-(void) setState:(PullLoadMoreState)aState;
- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@protocol LoadMoreTableFooterDelegate

-(void) loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTalbeFooterView*)view;

@end
