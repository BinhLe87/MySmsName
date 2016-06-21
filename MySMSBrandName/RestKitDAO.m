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
#import "smsProg.h"
#import "smsProgList.h"


@implementation RestKitDAO

-(void)configureRestKit {
    
    [RKObjectMapping alloc];
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:HOST_NAME];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    //---------------------------API_SIGNIN: user info
    // setup object mappings
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[UserDAO class]];
    [userMapping addAttributeMappingsFromArray:@[@"userName", @"token", @"errorCode", @"message"]];
    
    
    RKResponseDescriptor *userResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                 method:RKRequestMethodPOST
                                            pathPattern: API_SIGNIN
                                                keyPath: nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    //---------------------------API_GET_MESSAGE_PROGRESS: smsProgList
    // Create our new smsProg entity mapping
    RKObjectMapping* smsProgMapping = [RKObjectMapping mappingForClass:[smsProg class]];
    // NOTE: When your source and destination key paths are symmetrical, you can use addAttributesFromArray: as a shortcut instead of addAttributesFromDictionary:
    [smsProgMapping addAttributeMappingsFromArray:@[ @"prog_id", @"prog_code", @"alias", @"status", 
                @"content", @"progType", @"totalSub", @"totalSuccess", @"totalFail", @"created_date"]];
    
    // Now configure the Article mapping
    RKObjectMapping* smsProgListMapping = [RKObjectMapping mappingForClass:[smsProgList class] ];
    [smsProgListMapping addAttributeMappingsFromDictionary:@{
                                                         @"errorCode": @"errorCode",
                                                         @"message": @"message",
                                                         @"pageTotal": @"pageTotal"
                                                         }];
    
   
   
    
    
    // Define the relationship mapping
    [smsProgListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"data"
                                                                                   toKeyPath:@"smsProgArr"
                                                                                 withMapping:smsProgMapping]];
    

    RKResponseDescriptor *smsProgListresponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:smsProgListMapping method:RKRequestMethodAny pathPattern:API_GET_MESSAGE_PROGRESS
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    //---------------------
    
    [objectManager addResponseDescriptor:userResponseDescriptor];
    [objectManager addResponseDescriptor:smsProgListresponseDescriptor];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter  setDateFormat:@"dd/MM/yyyy HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:dateFormatter atIndex:0];
    
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/plain"];
}
@end
