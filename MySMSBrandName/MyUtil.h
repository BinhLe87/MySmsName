//
//  MyUtil.h
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/17/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUtil: NSObject

+(instancetype)sharedMyUtil;

-(void) printMyKeyValue:(NSString *)key;
-(void) printMyDefaultKeyValue;
-(instancetype) init;
@end
