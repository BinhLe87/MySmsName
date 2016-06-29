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

@interface SmsProgViewController : UITableViewController <LoadMoreTableFooterDelegate> {
    
    LoadMoreTalbeFooterView *footerView;
    int loadedPageIdx;
}

@property (nonatomic, readwrite) NSMutableArray *smsProgs;
@property (nonatomic) NSString *token;




- (void) loadSmsProgs:(int)pageID pageSize:(int)pageSize;


@end
