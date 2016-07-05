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
#import "SmsProgCell.h"

@protocol SmsProgViewDelegate;


@interface SmsProgViewController : UIViewController <LoadMoreTableFooterDelegate, SlideNavigationControllerDelegate> {
    
    LoadMoreTalbeFooterView *footerView;
    int loadedPageIdx;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite) NSMutableArray *smsProgs;
@property (nonatomic) NSString *token;
@property (nonatomic) id <SmsProgViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *addNewRowLbl;


- (void) loadSmsProgs:(int)pageID pageSize:(int)pageSize;
- (void)addSmsProg;
- (void) setHiddenStatus:(SmsProgCell *) cell hiddenStat:(BOOL)hiddenStat;

@end


@protocol SmsProgViewDelegate

-(void) didPrepareData;

@end
