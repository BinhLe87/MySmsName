//
//  SmsProgViewController.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsProgList.h"
#import "LoadMoreTalbeFooterView.h"
#import <SlideNavigationController.h>

@protocol SmsProgViewDelegate;


@interface SmsProgViewController : UITableViewController <LoadMoreTableFooterDelegate, SlideNavigationControllerDelegate> {
    
    LoadMoreTalbeFooterView *footerView;
    int loadedPageIdx;

}

@property (nonatomic, readwrite) NSMutableArray *smsProgs;
@property (nonatomic) NSString *token;
@property (nonatomic) id <SmsProgViewDelegate> delegate;


- (void) loadSmsProgs:(int)pageID pageSize:(int)pageSize;


@end


@protocol SmsProgViewDelegate

-(void) didPrepareData;

@end
