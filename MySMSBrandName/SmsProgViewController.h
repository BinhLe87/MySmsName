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



@interface SmsProgViewController : UIViewController <LoadMoreTableFooterDelegate, SlideNavigationControllerDelegate, SmsProgCellDelegate> {
    
    LoadMoreTalbeFooterView *footerView;
    int loadedPageIdx;
    CGPoint originTableInSuperview;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *addNewRowView;

@property (nonatomic, readwrite) NSMutableArray *smsProgs;
@property (nonatomic) NSString *token;
@property (nonatomic) id <SmsProgViewDelegate> delegate;

@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIView *activityView;
-(void)displayActivitySpinner;
-(void)removeActivitySpinner;


- (void) loadSmsProgs:(int)pageID pageSize:(int)pageSize;
- (void) addSmsProg;
- (void) setHiddenStatus:(SmsProgCell *) cell hiddenStat:(BOOL)hiddenStat;
- (void) changeEditModeStats;


@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *myTabGestureRecognizer;
@property (nonatomic, strong) NSIndexPath *swipedCellIndexPath;

- (IBAction)addNewRowTap:(id)sender;
-(void)didSwipeLeftInCellWithIndexPath:(NSIndexPath *)indexPath;
@end


@protocol SmsProgViewDelegate

-(void) didPrepareData;

@end
