//
//  LKAsiHttpUtil.h
//  LKDataHelper
//
//  Created by licrk on 13-12-11.
//  Copyright (c) 2013年 LK. All rights reserved.
//

typedef enum _LKHTTPMethod {
    LKHTTPMethodGet = 1,
    LKHTTPMethodPost = 2
    }LKHTTPMethod;

#import <Foundation/Foundation.h>
#import "ASIHTTP/ASIHTTPRequestDelegate.h"

#ifndef RequestFinishedBlock
#define RequestFinishedBlock
typedef void(^RequestFinished)(NSArray* array,id request);
#endif
@interface LKASIHttpUtil : NSObject<ASIHTTPRequestDelegate>
@property(nonatomic) BOOL isRequestFinished;
@property(nonatomic,strong) ASIHTTPRequest *request;

#pragma mark init method
-(id)initWithURL:(NSURL*)url;
-(id)initWithURL:(NSURL*)url method:(LKHTTPMethod)method;
-(id)setRequestURL:(NSURL*)url;
-(void)setTimeOut:(long)sec;


#pragma mark request method
-(id)getData;
-(void)getDataByCallBackGet:(SEL)method obj:(id)obj;
-(void)getDataByCallBackPost:(SEL)method obj:(id)obj data:(NSMutableDictionary*)data;
-(void)getDataByCallBackPost:(SEL)method obj:(id)obj data:(NSMutableDictionary*)data files:(NSDictionary*)files;


#if NS_BLOCKS_AVAILABLE
-(void)getDataByCallBackGet:(RequestFinished)requestFinished;
-(void)getDataByCallBackPostdata:(NSMutableDictionary*)data requestFinished:(RequestFinished)requestFinished;;
-(void)getDataByCallBackPostdata:(NSMutableDictionary*)data files:(NSDictionary*)files requestFinished:(RequestFinished)requestFinished;;
#endif

#pragma mark test data request

+(id)getDataWithTestJSONStr:(NSString*)jsonStr selector:(SEL)method obj:(id)obj;
@end
