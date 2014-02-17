//
//  LKAsiHttpUtil.m
//  LKDataHelper
//
//  Created by licrk on 13-12-11.
//  Copyright (c) 2013年 LK. All rights reserved.
//

#import "LKAsiHttpUtil.h"
#import "ASIHTTP/ASIHTTPRequest.h"
#import "ASIHTTP/ASIFormDataRequest.h"

@implementation LKASIHttpUtil{
    BOOL _isRequestFinished;
    SEL _orgMethod;
    id _orgObj;
    id _request;
    
}
@synthesize isRequestFinished=_isRequestFinished;
@synthesize request=_request;
#pragma mark init  
-(id)initWithURL:(NSURL *)url{
    self=[self initWithURL:url method:LKHTTPMethodGet];
    if (self) {
        
    }
    return self;
}

-(id)initWithURL:(NSURL *)url method:(LKHTTPMethod)method{
    if (method==LKHTTPMethodGet) {
        _request=[[ASIHTTPRequest alloc] initWithURL:url];
    }else if (method==LKHTTPMethodPost){
        _request=[[ASIFormDataRequest alloc] initWithURL:url];
    }
    return self;
}

#pragma mark self method
-(id)getData{
    _isRequestFinished=NO;
    [_request startSynchronous];
    _isRequestFinished=YES;
    return _request;
}

-(void)getDataByCallBackGet:(SEL)method obj:(id)obj{
    _isRequestFinished=NO;
    _orgMethod=method;
    _orgObj=obj;    
    [_request startAsynchronous];
}

-(void)getDataByCallBackPost:(SEL)method obj:(id)obj data:(NSMutableDictionary *)data{    
    _isRequestFinished=NO;
    _orgMethod=method;
    _orgObj=obj;
    for (NSString *key in [data allKeys]) {
        [_request setPostValue:[data objectForKey:key] forKey:key];
    }
    [_request startAsynchronous];

}
-(void)getDataByCallBackPost:(SEL)method obj:(id)obj data:(NSMutableDictionary *)data files:(NSDictionary *)files{
    _isRequestFinished=NO;
    _orgMethod=method;
    _orgObj=obj;
    for (NSString *key in [data allKeys]) {
        [_request setPostValue:[data objectForKey:key] forKey:key];
    }
    for (NSString *key in [files allKeys]) {
        [_request setFile:[files objectForKey:key] forKey:key];
    }
    [_request startAsynchronous];
}

#pragma mark httprequest delegate
-(void)requestFinished:(ASIHTTPRequest *)request{
    _isRequestFinished=YES;
    if ([_orgObj respondsToSelector:_orgMethod]) {
        [_orgObj performSelector:_orgMethod withObject:nil withObject:request];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"%d",[request responseStatusCode]);
}

#pragma mark dealloc
-(void)dealloc{
    [_request cancel];
}
    
    



@end
