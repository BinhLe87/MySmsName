//
//  smsProg.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/21/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "smsProg.h"

@implementation smsProg

-(instancetype)initDefault4New {
    
    self = [super init];
    
    if(self) {
        
        _prog_id = @"ProgID_NEW";
        _prog_code = @"ProgCode_NEW";
        _alias = @"Alias_NEW";
        _status = @"Status_NEW";
        _created_date = @"CreatedDate_NEW";
    }
    return self;
}


@end
