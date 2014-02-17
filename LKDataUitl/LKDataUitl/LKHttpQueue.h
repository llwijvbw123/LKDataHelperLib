//
//  LKHttpQueue.h
//  LKDataHelper
//
//  Created by licrk on 13-12-11.
//  Copyright (c) 2013年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef RequestFinishedBlock
#define RequestFinishedBlock
typedef void(^RequestFinished)(NSArray* array,id request);
#endif
@interface LKHttpQueue : NSObject

//一次普通的请求
-(void) createRequest:(NSURL*)url callback:(SEL)callback orgObj:(id)obj;
//一次没有附件的post请求
-(void) createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data  callback:(SEL)callback orgObj:(id)obj;
//一次拥有附件的post请求
-(void) createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data files:(NSDictionary*)files callback:(SEL)callback orgObj:(id)obj;

#if NS_BLOCKS_AVAILABLE
-(void) createBlockRequest:(NSURL *)url requestFinished:(RequestFinished)requestFinished;

-(void) createBlockRequestPost:(NSURL *)url data:(NSMutableDictionary*)data requestFinished:(RequestFinished)requestFinished;

-(void) createBlockRequestPost:(NSURL *)url data:(NSMutableDictionary*)data files:(NSDictionary*)files callback:(SEL)callback orgObj:(id)obj requestFinished:(RequestFinished)requestFinished;

#endif
@end
