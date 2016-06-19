//
//  MyUtil.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/17/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "MyUtil.h"

@implementation MyUtil

-(instancetype)init {
    
    return [super init];
}


+(instancetype)sharedMyUtil {
    
    static MyUtil *sharedMyUtil;
    
    if(!sharedMyUtil) {
        
        sharedMyUtil = [[self alloc] init];
    }
    
    return sharedMyUtil;
}



-(void) printMyKeyValue:(NSString *)key {
    
    NSString *string = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    
    NSLog(@"Current Configuration > %@", string);

}

-(void) printMyDefaultKeyValue {
    
    [self printMyKeyValue:@"TRACE_SETTING_VALUE"];
}

@end
