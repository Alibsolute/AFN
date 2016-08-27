//
//  NetworkingManager.m
//  AFN
//
//  Created by ABS on 16/2/6.
//  Copyright © 2016年 ABS. All rights reserved.
//

#import "NetworkingManager.h"

@implementation NetworkingManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        //请求超时设定
        self.requestSerializer.timeoutInterval = 10;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        self.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"application/json",@"text/plain",@"text/javascript",@"text/json",@"text/html", nil];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

+ (instancetype)sharedManagerWithURL:(NSURL *)url {
    static NetworkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return manager;
}

- (void)requestWithMethod:(HTTPMethod)method
                 withPath:(NSString *)path
               withParams:(NSDictionary *)params
         withSuccessBlock:(requestSuccessBlock)success
         withFailureBlock:(requestFailureBlock)failure {
    switch (method) {
        case GET: {
            [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            break;
        }
        case POST: {
            [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            break;
        }
        case PUT: {
            [self PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            break;
        }
        case DELETE: {
            [self DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            break;
        }
        case HEAD: {
            [self HEAD:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)downloadTaskWithPath:(NSString *)path
   withDownloadFinishedBlock:(downloadFinishedBlock)block {
    NSURLSessionDownloadTask *downloadTask = [self downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        block(filePath,error);
    }];
    [downloadTask resume];
}

- (void)uploadTaskWithRequestPath:(NSString *)requestPath
                     withFilePath:(NSString *)filePath
          withUploadFinishedBlock:(uploadFinishedBlock)block {
    NSURLSessionUploadTask *uploadTask = [self uploadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestPath]] fromFile:[NSURL URLWithString:filePath] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            block(NO,error);
        } else {
            block(YES,nil);
        }
    }];
    [uploadTask resume];
}
















@end
