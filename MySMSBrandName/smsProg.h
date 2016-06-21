//
//  smsProg.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/21/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface smsProg : NSObject

@property(nonatomic) NSString *prog_id;
@property(nonatomic) NSString *prog_code;
@property(nonatomic) NSString *alias;
@property(nonatomic) NSString *status;
@property(nonatomic) NSString *created_date;
@property(nonatomic) NSString *content;
@property(nonatomic) NSNumber *progType;
@property(nonatomic) NSNumber *totalSub;
@property(nonatomic) NSNumber *totalSuccess;
@property(nonatomic) NSNumber *totalFail;

@end
