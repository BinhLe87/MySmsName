//
//  Constant.h
//  MyName
//
//  Created by nghiendv on 4/17/15.
//  Copyright (c) 2015 nghiendv. All rights reserved.
//

#ifndef MyName_Constant_h
#define MyName_Constant_h

#define MESSAGE_MAX_LENGTH 480

#define PATTERN_PHONE @"^[\\+0-9]{3,20}$"

#define FIRST_INTRO @"first_intro"

//API

#define BRAND_MAX_LENGTH 11

#define KTIME_OUT 30

#define TIME @"slot"

#define TOKEN @"token"

#define STATUS @"status"

#define REG_FEE @"reg_name_fee"

#define MESSAGE @"message"

#define PASSWORD @"password"

#define PHONENUMBER @"phone_number"

#define USERNAME @"userName"

#define NUMBER_OF_NAMES @"number_of_names"

#define FIRST_LOGIN @"is_first_login"

#define ADDRESSBOOKS @"addressBooks"

#define LOAD_ADDRESS @"loadAddress"

//#define HOST_NAME @"http://myname.com.vn:9669/%@"
#define HOST_NAME @"http://203.190.170.41:9669/"


#define API_AUTHENTICATE @"getAuthenticate"

#define API_GETCODE @"getOTP"

#define API_SIGNIN @"getSignin"

#define API_VALIDATE_TOKEN @"validateToken"

#define API_GET_GROUP @"getGroups"

#define API_CREATE_GROUP @"createGroup"

#define API_DEL_GROUP @"deleteGroup"

#define API_EDIT_GROUP @"editGroup"

#define API_GET_BRANDS @"getBrands"

#define API_REGISTER_BRANDS @"registerBrand"

#define API_DEL_BRANDS @"deleteBrand"

#define API_GET_LIST_MSG @"getListMessage"

#define API_SEARCH_MSG @"searchMessagesByContent"

#define API_GET_SEND_MSG @"getListMessageSentSuccess"

#define API_SEARCH_SEND_MSG @"searchMessageSentSuccessByContent"

#define API_SEARCH_WAIT_MSG @"searchWaitingMessagesByContent"

#define API_GET_WAIT_MSG @"getWaitingMessages"

#define API_EDIT_WAIT_MSG @"editWaitingMessage"

#define API_DEL_WAIT_MSG @"deleteWaitingMessage"

#define API_SEND_MSG @"sendMessage"

#define API_ADD_NUM_GROUP @"addNumbersToGroup"

#define API_DEL_NUM_GROUP @"deleteNumbersInGroup"

#define API_ACC_MANAGER @"accountManager"

#define API_BUY_HISTORY @"buyHistory"

#define API_BUY_MORE_SMS @"buyMoreSMS"

#define API_GET_PRICE_POLICY @"getPolicyPrice"

#define API_GET_POLICY @"getPolicy"

#define API_GET_MESSAGE_PROGRESS @"getMessageProgs"

#define API_CARD_HISTORY @"scratchCardHistory"

#define API_GET_PHONE_GROUP @"getPhoneInGroup"

//CORE
#define PATTERN_VIETTEL @"^(\\+84|84|0|)+(96|97|98|16[1-9])+[0-9]{7}$"

//COLOR
#define BLACK 0x303030

#define LIGHT_BLACK 0x3C404B

#define GRAY 0x353535

#define LIGHT_GRAY 0xB9B9B9

#define WHITE 0xFFFFFF

#define BLUE 0x00BCD4

#define BLUE_BOLD 0x0097C2

#define RED 0xFC303F

#define BACKGROUND_COLOR 0xF2F2F2

//FONT

#define FONT_SIZE 14

#define FONT_BIG_SIZE 16

#define FONT_BIG_BIG_SIZE 18

#define FONT_NAME @"Roboto-Regular"

#define FONT_NAME_THIN @"Roboto-Light"

#define FONT_NAME_BOLD @"Roboto-Medium"

#endif
