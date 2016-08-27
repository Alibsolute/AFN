//
//  NetworkingManager.h
//  AFN
//
//  Created by ABS on 16/2/6.
//  Copyright © 2016年 ABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFN-Bridging-Header.h"

typedef void (^requestSuccessBlock) (id responseObject);
typedef void (^requestFailureBlock) (NSError *error);
typedef void (^downloadFinishedBlock) (NSURL *filePath, NSError *error);
typedef void (^uploadFinishedBlock) (BOOL success, NSError *error);

typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface NetworkingManager : AFHTTPSessionManager

/**
 *  <#Description#>
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedManagerWithURL:(NSURL *)url;

/**
 *  <#Description#>
 *
 *  @param method  <#method description#>
 *  @param path    <#path description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)requestWithMethod:(HTTPMethod)method
                 withPath:(NSString *)path
               withParams:(NSDictionary *)params
         withSuccessBlock:(requestSuccessBlock)success
         withFailureBlock:(requestFailureBlock)failure;

/**
 *  <#Description#>
 *
 *  @param path       <#path description#>
 *  @param block      <#block description#>
 */
- (void)downloadTaskWithPath:(NSString *)path
   withDownloadFinishedBlock:(downloadFinishedBlock)block;

/**
 *  <#Description#>
 *
 *  @param requestPath <#requestPath description#>
 *  @param filePath    <#filePath description#>
 *  @param block       <#block description#>
 */
- (void)uploadTaskWithRequestPath:(NSString *)requestPath
                     withFilePath:(NSString *)filePath
          withUploadFinishedBlock:(uploadFinishedBlock)block;

@end
