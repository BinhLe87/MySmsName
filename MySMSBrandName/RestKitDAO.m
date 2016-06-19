//
//  RestKitDAO.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "RestKitDAO.h"
#import "Constant.h"
#import <RestKit/RestKit.h>
#import "UserDAO.h"

@implementation RestKitDAO

-(void)configureRestKit {
    
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:HOST_NAME];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[UserDAO class]];
    [userMapping addAttributeMappingsFromArray:@[@"userName", @"token", @"errorCode"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                 method:RKRequestMethodPOST
                                            pathPattern: API_SIGNIN
                                                keyPath: nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/plain"];
}
@end
