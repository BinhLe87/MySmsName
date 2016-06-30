//
//  LeftMenuViewController.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/29/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SlideNavigationController.h>

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;


@property (weak, nonatomic) IBOutlet UITableViewCell *leftMenuTableCell;

@property (weak, nonatomic) IBOutlet UILabel *leftMenuIItemLbl;


@end
