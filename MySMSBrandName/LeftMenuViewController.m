//
//  LeftMenuViewController.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/29/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "LeftMenuViewController.h"
#import <SlideNavigationController.h>

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    
    return [super initWithCoder:aDecoder];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];
    self.tableView.backgroundView = imageView;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    [SlideNavigationController sharedInstance].portraitSlideOffset = 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    
//    if (cell == nil) {
//        
//        cell = _leftMenuTableCell;
//    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftMenuCell"];
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Home";
            break;
            
        case 1:
            cell.textLabel.text = @"Sign Out";
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            NSLog(@"Da chon Home");
            break;
        case 1:
            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
            [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
            return;
            break;
            
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
