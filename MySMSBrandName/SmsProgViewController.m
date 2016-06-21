//
//  SmsProgViewController.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "SmsProgViewController.h"
#import <RestKit/RestKit.h>
#import "Constant.h"
#import "smsProgList.h"
#import "smsProg.h"

@interface SmsProgViewController ()

@property (nonatomic) void (^fetchCompletedBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
@end

@implementation SmsProgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //Load the NIB file
    UINib *smsProgCellNib = [UINib nibWithNibName:@"SmsProgCell" bundle:nil];
    
    [self.tableView registerNib:smsProgCellNib forCellReuseIdentifier:@"SmsProgCell"];
    
    [self loadSmsProgs:1 pageSize:10];
    
    smsProg *prog = (smsProg *)[_smsProgs.smsProgs objectAtIndex:1];
    
    NSLog(@"gia tri la %@", prog.prog_code);
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmsProgCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (smsProgList *)loadSmsProgs:(int)pageID pageSize:(int)pageSize {
    
    __block smsProgList *smsProgArr = nil;
    
    
    self.fetchCompletedBlock = ^ (RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        _smsProgs = (smsProgList *) mappingResult.firstObject;
    };
    
    
    NSDictionary *params = @{@"token":  _token, @"page_id": [NSNumber numberWithInt:pageID], @"page_size": [NSNumber numberWithInt:pageSize]};
   
     [[RKObjectManager sharedManager] postObject:nil path:API_GET_MESSAGE_PROGRESS parameters:params success:_fetchCompletedBlock failure:^(RKObjectRequestOperation *operation, NSError *error) {
         
     }];
    
    return smsProgArr;
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
