//
//  SmsProgViewController.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "SmsProgViewController.h"
#import <RestKit/RestKit.h>
#import "smsProgList.h"
#import "smsProg.h"
#import "SmsProgCell.h"

@interface SmsProgViewController ()

@property (nonatomic) void (^fetchCompletedBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
@end

@implementation SmsProgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loadedPageIdx = 1;
    _smsProgs = [[NSMutableArray alloc] init];
    
   //Load the NIB file
    UINib *smsProgCellNib = [UINib nibWithNibName:@"SmsProgCell" bundle:nil];
    
    [self.tableView registerNib:smsProgCellNib forCellReuseIdentifier:@"SmsProgCell"];
    
    
    
    if (footerView == nil)
    {
        footerView = [[LoadMoreTalbeFooterView alloc] initWithFrame:CGRectMake(0.0f, self.tableView.contentSize.height, self.view.frame.size.width, 60)];
        
        footerView.delegate = self;
        [self.tableView addSubview:footerView];
    }

    
   [self loadSmsProgs:loadedPageIdx pageSize:10];
   [self reloadData];
}

- (void)reloadData
{
    [self.tableView reloadData];
    
    footerView.frame = CGRectMake(0.0f, self.tableView.contentSize.height, self.view.frame.size.width, self.tableView.bounds.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _smsProgs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SmsProgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmsProgCell" forIndexPath:indexPath];

    smsProg *objSmsProg = (smsProg *)[_smsProgs objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    cell.progCodeLbl.text = objSmsProg.prog_code;
    cell.progStatLbl.text = [NSString stringWithFormat:@"Trạng thái: %@", objSmsProg.status];
    cell.progAliasLbl.text = objSmsProg.alias;
    cell.progCreatedDateLbl.text = objSmsProg.created_date;
    
    return cell;
}

- (void)loadSmsProgs:(int)pageID pageSize:(int)pageSize {
    
//    NSURL *aUrl = [NSURL URLWithString:@"http://203.190.170.41:9669/getMessageProgs"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    
//    [request setHTTPMethod:@"POST"];
//    NSString *postString = [NSString stringWithFormat:@"page_id=%d&page_size=%d&token=%@", pageID, pageSize, _token];
//    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        
//    }];
    
    NSDictionary *params = @{@"token":  _token, @"page_id": [NSNumber numberWithInt:pageID], @"page_size": [NSNumber numberWithInt:pageSize]};
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodPOST path:API_GET_MESSAGE_PROGRESS parameters:params];
    [operation setCompletionBlockWithSuccess:nil failure:nil];
   // [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    smsProgList *objSmsProgList = [[smsProgList alloc] init];

    
    [operation start];
    [operation waitUntilFinished];
    
    if (!operation.error) {
        
        objSmsProgList = (smsProgList *) [operation.mappingResult firstObject];
    }
    
    for (smsProg* aSmsProg in objSmsProgList.smsProgArr) {
        [_smsProgs addObject:aSmsProg];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *sectionHeader = [[UILabel alloc] init];
    sectionHeader.frame = CGRectMake(0, 0, tableView.frame.size.width, 23);
    sectionHeader.font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE]; 
    
    NSDateFormatter *dateTimeFormat = [[NSDateFormatter alloc] init];
    [dateTimeFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    NSString *date = [[_smsProgs objectAtIndex:section] valueForKey:@"created_date"];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[dateTimeFormat dateFromString:date]
                                                          toDate:[NSDate date]
                                                         options:NSCalendarWrapComponents];
    
    
    if (components.day == 0) {
        date = [NSString stringWithFormat:@"Hôm nay %@", date];
    }
    else if (components.day == 1) {
        date = [NSString stringWithFormat:@"Hôm qua %@", date];
    }
    else {
        date = [NSString stringWithFormat:@"Ngày %@", date];
    }
    
    sectionHeader.textColor =  UIColorFromRGB(BLUE);
    sectionHeader.text = date;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    [headerView addSubview:sectionHeader];
    headerView.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
   sectionHeader.center = CGPointMake((tableView.frame.size.width) / 2 + 10, headerView.frame.size.height / 2);
    
    return headerView;

    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [footerView loadMoreScrollViewDidScroll:scrollView];
}

-(void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTalbeFooterView *)view {
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        loadedPageIdx = loadedPageIdx + 1;
        [self loadSmsProgs:loadedPageIdx pageSize:10];
        [self reloadData];
    });
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
