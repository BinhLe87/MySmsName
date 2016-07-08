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
#import "SmsProgDetailViewController.h"
#import "SmsProgViewController+SearchBar.h"


@interface SmsProgViewController ()


@property (nonatomic) void (^fetchCompletedBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
@end

@implementation SmsProgViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"D.sách chương trình";
        navItem.rightBarButtonItem = self.editButtonItem;
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor redColor],
           NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:13]}];
        
        _filteredTableData = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (IBAction)addNewRowTap:(id)sender {
    
    NSLog(@"tap 'Add New Row'");
    
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self tableView:_tableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:idxPath];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    _mainWindow = [[UIApplication sharedApplication] keyWindow];
    [_mainWindow setBackgroundColor:[UIColor whiteColor]];
    
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:animated];
    
    originTableInSuperview = [self.mainWindow convertPoint:CGPointMake(0, 0) fromView:self.tableView];
}

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
    
    
    //set up search controller
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles = @[@"Prog Code", @"Prog Status"];
    
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
    
    self.searchController.delegate = self;
    
    [self.searchController.searchBar sizeToFit];
}

- (void)listSubviewsOfView:(UIView *)view level:(int)level {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return; // COUNT CHECK LINE
    
    for (UIView *subview in subviews) {
        
        // Do what you want to do with the subview
        NSLog(@"level %d: %@", level, subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview level:level+1];
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
 
    int heightMoveUp = -[[UIApplication sharedApplication] statusBarFrame].size.height -self.navigationController.navigationBar.frame.size.height;
    
    [UIView animateWithDuration:0 animations:^{
        
        [_addNewRowView setFrame:CGRectMake(0, heightMoveUp, _addNewRowView.frame.size.width, _addNewRowView.frame.size.height)];
    }];
 
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    

    [UIView animateWithDuration:0.1 animations:^{
        
        [_addNewRowView setFrame:CGRectMake(0, 0, _addNewRowView.frame.size.width, _addNewRowView.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self reloadData];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self reloadData];
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = searchController.searchBar.text;
    
    if(self.filteredTableData) {
    
        [self.filteredTableData removeAllObjects];
    }
    
    [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self reloadData];
}


- (void)searchForText:(NSString *)searchText scope:(SmsProgSearchScope)scopeOption {
    
    for (smsProg *smsProgEntity in self.smsProgs) {
        
        if (scopeOption == searchScopeProgStatus) { //search by prog status
            
            if([[smsProgEntity.status lowercaseString] containsString:[searchText lowercaseString]]) {
                
                [self.filteredTableData addObject:smsProgEntity];
                NSLog(@"Matched prog_code/prog_staus: %@", smsProgEntity);
            }
        } else {
            
            if([[smsProgEntity.prog_code lowercaseString] containsString:[searchText lowercaseString]]) {
                
                [self.filteredTableData addObject:smsProgEntity];
                NSLog(@"Matched prog_code: %@", smsProgEntity);
            }
            
        }
    }
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Detemine if it's in editing mode
    if (self.tableView.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexSet *indexPathSet;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        indexPathSet  = [NSIndexSet indexSetWithIndex:indexPath.section];
        [self.smsProgs removeObjectAtIndex:indexPath.section];
        [self.tableView deleteSections:indexPathSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if(editingStyle == UITableViewCellEditingStyleInsert) {
        
        indexPathSet  = [NSIndexSet indexSetWithIndex:0];
        smsProg *objSmsProgNew = [[smsProg alloc] initDefault4New];
        
        [self.smsProgs insertObject:objSmsProgNew atIndex:0];
        [self.tableView insertSections:indexPathSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [self reloadData];
}

-(void)setEditing:(BOOL)editing {
    
    [super setEditing:editing];
    
    [self setEditing:editing animated:YES];
    
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
    
    if(editing) {
        
        [self.editButtonItem initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(changeEditModeStats)];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DisableGestureOnCell" object:self];
    } else {
        [self.editButtonItem initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(changeEditModeStats)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableGestureOnCell" object:self];
    }
}

- (void) changeEditModeStats{
    
    if ([self.tableView isEditing]) {
        
        [self setEditing:NO animated:YES];
    } else {
        
        [self setEditing:YES animated:YES];
    }
    
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
    if (self.searchController.active)
    {
        return [self.filteredTableData count];
    }
    else
    {
        return _smsProgs.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (void) setHiddenStatus:(SmsProgCell *) cell hiddenStat:(BOOL)hiddenStat {
    
    cell.progIDLbl.hidden = hiddenStat;
    cell.progCodeLbl.hidden = hiddenStat;
    cell.progStatLbl.hidden = hiddenStat;
    cell.progAliasLbl.hidden = hiddenStat;
    cell.progCreatedDateLbl.hidden = hiddenStat;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SmsProgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmsProgCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    
    smsProg *objSmsProg = [[smsProg alloc] init];
    
    if (self.searchController.active)
    {
        objSmsProg = [self.filteredTableData objectAtIndex:indexPath.section];
    }
    else
    {
        objSmsProg  = [self.smsProgs objectAtIndex:indexPath.section];
    }
    
    
    // Configure the cell...
    cell.progIDLbl.text = [NSString stringWithFormat:@"Prog Id: %@", objSmsProg.prog_id];
    cell.progCodeLbl.text = objSmsProg.prog_code;
    cell.progStatLbl.text = [NSString stringWithFormat:@"Trạng thái: %@", objSmsProg.status];
    cell.progAliasLbl.text = objSmsProg.alias;
    cell.progCreatedDateLbl.text = objSmsProg.created_date;
    
    //only show AccessoryIndicator for rows have totolSub's value is greater than 1
    if([objSmsProg.totalSub intValue] > 1) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


- (void)didSwipeLeftInCellWithIndexPath:(NSIndexPath *)indexPath {
    
    // Check if the newly-swiped cell is different to the currently swiped cell – if it is, ‘unswipe’ it
    if (_swipedCellIndexPath.section != indexPath.section) {
        
        // Unswipe the currently swiped cell
        SmsProgCell *currentSwipedCell = (SmsProgCell*) [self.tableView cellForRowAtIndexPath:_swipedCellIndexPath];
        [currentSwipedCell didResetSwipeLeftInCell];
    }
    
    _swipedCellIndexPath = indexPath;
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
    
    NSLog(@"Lay du lieu trang %d", pageID);
    
    NSDictionary *params = @{@"token":  _token, @"page_id": [NSNumber numberWithInt:pageID], @"page_size": [NSNumber numberWithInt:pageSize]};
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodPOST path:API_GET_MESSAGE_PROGRESS parameters:params];
    [operation setCompletionBlockWithSuccess:nil failure:nil];
    // [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    smsProgList *objSmsProgList = [[smsProgList alloc] init];
    
    // [NSThread sleepForTimeInterval:10];
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
    
    NSString *date;
    
    if(self.searchController.active) {
        
        date = [[_filteredTableData objectAtIndex:section] valueForKey:@"created_date"];
    } else {
        
        date = [[_smsProgs objectAtIndex:section] valueForKey:@"created_date"];
    }
    
    
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
    
    if(_swipedCellIndexPath) {
        
        // Unswipe the currently swiped cell
        SmsProgCell *currentSwipedCell = (SmsProgCell*) [self.tableView cellForRowAtIndexPath:_swipedCellIndexPath];
        [currentSwipedCell didResetSwipeLeftInCell];
    }
    
    [footerView loadMoreScrollViewDidScroll:scrollView];
}

-(void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTalbeFooterView *)view {
    
    loadedPageIdx = loadedPageIdx + 1;
    [self loadSmsProgs:loadedPageIdx pageSize:10];
    
    [self reloadData];
    
    
    
}

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SmsProgDetailViewController *objSmsProgDetailVC = [[SmsProgDetailViewController alloc] initWithNibName:@"SmsProgDetailViewController" bundle:nil];
    
    objSmsProgDetailVC.smsProgEntity = (smsProg *)[self.smsProgs objectAtIndex:indexPath.section];
    
    
    
    [self.navigationController pushViewController:objSmsProgDetailVC animated:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    if (contentOffsetY < -60.0) {
        
        [self displayActivitySpinner]; }
    
}

-(void)displayActivitySpinner {
    
    _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, originTableInSuperview.y, 320, 60)];
    [_activityView setBackgroundColor:[UIColor whiteColor]];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    [_activityIndicator setFrame:CGRectMake(145, 20, 30, 30)];
    [_activityIndicator startAnimating];
    [_activityView addSubview:_activityIndicator];
    
    [_mainWindow addSubview:_activityView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.tableView setFrame:CGRectMake(0, 110, 320, 480)]; } completion:^(BOOL finished) { [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(removeActivitySpinner) userInfo:nil repeats:NO];
            
        }];
}

-(void)removeActivitySpinner {
    [_activityIndicator stopAnimating];
    [_activityView removeFromSuperview];
    [UIView animateWithDuration:0 animations:^{
        CGRect currentTableRect = self.tableView.frame;
        [self.tableView setFrame:CGRectMake(0, 110 - 60, currentTableRect.size.width,currentTableRect.size.height)];
    }];
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
