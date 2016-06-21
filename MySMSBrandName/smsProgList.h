//
//  smsProgList.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/21/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface smsProgList : NSObject

@property(nonatomic) NSString *errorCode;
@property(nonatomic) NSString *message;
@property(nonatomic) NSNumber *pageTotal;
@property(nonatomic) NSMutableArray *smsProgs;

@end
