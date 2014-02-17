//
//  LKHttpQueue.m
//  LKDataHelper
//
//  Created by licrk on 13-12-11.
//  Copyright (c) 2013年 LK. All rights reserved.
//

#import "LKHttpQueue.h"
#import "LKASIHttpUtil.h"

@implementation LKHttpQueue{
    RequestFinished requestFinishedBlock;
    NSMutableArray *requestQueue;
}
-(id)init{
    self=[super init];
    if (self) {
        requestQueue=[[NSMutableArray alloc] init];
    }
    return self;
}
//not use , use initHttp
-(LKASIHttpUtil *)getRequestFinishedHttpRequest{
    for (LKASIHttpUtil *http in requestQueue) {
        if (http.isRequestFinished==YES) {
            return http;
        }
    }
    return nil;
}
-(id) initHttp:(NSURL*)url{
    id request=[self getRequestFinishedHttpRequest];
    if (request==nil) {
        request=[[LKASIHttpUtil alloc] initWithURL:url];
    }else{
        [request setRequestURL:url];
    }
    return request;
}

-(void)createRequest:(NSURL *)url callback:(SEL)callback  orgObj:(id)obj{
    LKASIHttpUtil *request=(LKASIHttpUtil*)[self initHttp:url];
    [request getDataByCallBackGet:callback obj:obj];
    [requestQueue addObject:request];
}
-(void)createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data callback:(SEL)callback  orgObj:(id)obj {
    LKASIHttpUtil *request=(LKASIHttpUtil*)[self initHttp:url];
    [request getDataByCallBackPost:callback obj:obj data:data];
    [requestQueue addObject:request];
}
-(void)createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data files:(NSDictionary*)files callback:(SEL)callback  orgObj:(id)obj {
    LKASIHttpUtil *request=(LKASIHttpUtil*)[self initHttp:url];
    [request getDataByCallBackPost:callback obj:obj data:data files:files];
    [requestQueue addObject:request];
}

#pragma mark block request

-(void)createBlockRequest:(NSURL *)url requestFinished:(RequestFinished)requestFinished{
    LKASIHttpUtil *request=(LKASIHttpUtil*)[self initHttp:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [request getData];
        requestFinished([NSArray arrayWithObject:@""],request.request);
    });
}

-(void)dealloc{
    NSLog(@"queue dealloc");
}

@end
