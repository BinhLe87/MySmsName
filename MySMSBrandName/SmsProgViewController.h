//
//  SmsProgViewController.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsProgList.h"


@interface SmsProgViewController : UITableViewController

@property (nonatomic, readwrite) smsProgList *smsProgs;
@property (nonatomic) NSString *token;



- (NSMutableArray*) loadSmsProgs:(int)pageID pageSize:(int)pageSize;

@end
