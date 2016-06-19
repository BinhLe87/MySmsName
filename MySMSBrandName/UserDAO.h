//
//  UserDAO.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDAO : NSObject


@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *token;
@property (nonatomic) int errorCode;
@property (nonatomic) NSString *message;
@end
