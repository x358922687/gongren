//
//  HttpTool.m
//
//  https://github.com/guodongZhao/ZGDAFNetworking-Tool.git
//  Created by yhj on 16/3/5.
//  Copyright © 2016年 yhj. All rights reserved.
//  https://github.com/guodongZhao.

#import "HttpTool.h"
#import "AFNetworking.h"


#warning 请设置服务器基地址
static NSString *const kBaseURLString = @"http://121.43.185.224:8080/house/";
static inline NSData * image2Data(UIImage *img,CGFloat num) {
    NSData *d = UIImageJPEGRepresentation(img,num);
    if (d == nil) {
        d = UIImageJPEGRepresentation(img, num);
    }
    return d;
}


@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient
{
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString] sessionConfiguration:configuration];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end

@implementation HttpTool

#pragma mark - AFN网络请求
#pragma mark POST请求
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure{
    // 获取完整的URL
    NSString *urlString = [kBaseURLString stringByAppendingPathComponent:path];
    // 实例化请求
    NSError *error = nil;
    AFHTTPRequestSerializer *manager = [AFHTTPRequestSerializer serializer];
    manager.timeoutInterval = 100;
    
    NSMutableURLRequest *request = [manager requestWithMethod:@"POST" URLString:urlString parameters:params error:&error];
    if (error) failure(error);
    
    // 开始获取数据
    [[[AFHttpClient sharedClient] dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        //        uploadProgressTool(uploadProgress.fractionCompleted);
      //  NSLog(@"开始上传");
        
        // 上传
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        //        downloadProgressTool(downloadProgress.fractionCompleted);
       // NSLog(@"开始下载");
        // 下载
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
            DLog(@"网络连接失败失败  错误路径:%@错误码%zd ",path,error.code);
 
        }
        else {
            
            success(responseObject);
            
            DLog(@"网络连接成功");
            
        }
    }] resume];
    
}

#pragma mark GET请求
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure
{
    // 获取完整的URL
    NSString *urlString = [kBaseURLString stringByAppendingPathComponent:path];
    // 实例化请求
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:params error:&error];
    if (error) failure(error);
    // 开始获取数据
    [[[AFHttpClient sharedClient] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
            DLog(@"网络连接失败失败  错误路径:%@错误码%zd ",path,error.code);
            
        }
        else {
            success(responseObject);
        }
    }] resume];
    
    
}

#pragma mark - POST上传图片
+ (void)postWithImgPath:(NSString *)path
                 params:(NSDictionary *)params
                 imagesData:(NSArray *)images
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure
               progress:(HttpUploadProgressBlock)progress

{
    // 获取完整的URL
    NSString *urlString = [kBaseURLString stringByAppendingPathComponent:path];
    
    // 实例化请求
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSUInteger idx = 0; idx < images.count; idx ++) {
            ImageDataParam *immData = images[idx];
            [formData appendPartWithFileData:immData.data name:immData.name fileName:immData.fileName mimeType:immData.mimeType];
        }
    } error:nil];
    if (error) failure(error);
    
    
    // 开始上传图片
    [[[AFHttpClient sharedClient] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // 返回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 图片上传进度
            progress(uploadProgress.fractionCompleted);
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }
        else {
            success(responseObject);
        }
    }] resume];
}

+ (void)postWithOneImgPath:(NSString *)path
                 params:(NSDictionary *)params
                 imageData:(ImageDataParam *)imageData
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure
               progress:(HttpUploadProgressBlock)progress

{
    // 获取完整的URL
    NSString *urlString = [kBaseURLString stringByAppendingPathComponent:path];
    
    // 实例化请求
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData.data name:imageData.name fileName:imageData.fileName mimeType:imageData.mimeType];
            
        
    } error:nil];
    if (error) failure(error);
    
    
    // 开始上传图片
    [[[AFHttpClient sharedClient] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // 返回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 图片上传进度
            progress(uploadProgress.fractionCompleted);
        });
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }
        else {
            success(responseObject);
        }
    }] resume];
}

#pragma mark - 文件下载
+ (void)dowloadWithPath:(NSString *)path
                success:(HttpDowloadBlock)success
                failure:(HttpFailureBlock)failure
               progress:(HttpDowloadProgressBlock)progress
{
    // 获取完整的URL
    NSString *urlString = [kBaseURLString stringByAppendingPathComponent:path];
    
    // 实例化请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // 开始下载
    [[[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            progress(downloadProgress.fractionCompleted);
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 设置文件的保存地址
        NSURL *cacheUrl = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [cacheUrl URLByAppendingPathComponent:[response suggestedFilename]];
        return cacheUrl;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 文件下载并保存成功后的回调
        if (error) {
            failure(error);
        }
        else {
            success(filePath.path);
        }
    }] resume];
}

#pragma mark - POST上传视频
+(void)postWithVideoPath:(NSString *)path
                  params:(NSDictionary *)params
                   video:(NSData *)video
              videoImage:(NSData *)videoImage
    videoImageParamsName:(NSString *)VideoParamsImageName
         videoParamsName:(NSString *)VideoParamsName
                 hudView:(UIView *)hudView
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpUploadProgressBlock)progress
{
    // 获取完整的URL
    NSString *urlString = [kBaseURLString stringByAppendingPathComponent:path];
    // 实例化请求
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (video != nil) {
            [formData appendPartWithFileData:video name:VideoParamsName fileName:[NSString stringWithFormat:@"%@.mp4", VideoParamsName] mimeType:[NSString stringWithFormat:@"%@/mp4", VideoParamsName]];
        }
        if (videoImage != nil) {
            [formData appendPartWithFileData:videoImage name:VideoParamsImageName fileName:[NSString stringWithFormat:@"%@.jpg", VideoParamsImageName] mimeType:[NSString stringWithFormat:@"%@/jpg", VideoParamsImageName]];
        }
    } error:nil];
    if (error) failure(error);
    // 开始上传
    [[[AFHttpClient sharedClient] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        // 返回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 上传进度
            progress(uploadProgress.fractionCompleted);
        });
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
           DLog(@"网络连接失败失败  错误路径:%@错误码%zd ",path,error.code);
            [NSThread sleepForTimeInterval:2.0];
            
            
        }
        else {
            success(responseObject);
        }
    }] resume];
    
}

#pragma mark -隐藏多余分割线

+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

@end

@implementation NSDictionary(Oto)

- (BOOL)isSuccess
{
    
    return [self[@"code"]  isEqualToString:@"1"];
}
- (void)showErrorMesg
{
    NSString *error = self[@"msg"];
    if (error && [error isKindOfClass:[NSString class]]) {
        
        [SVProgressHUD showErrorWithStatus:error];
    }
}
- (NSMutableDictionary *)deleteAllNullValue{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    
    for (NSString *keyStr in self.allKeys) {
        
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
            
        }
        
        else{
            
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
            
        }
        
    }
    
    return mutableDic;
    
}
@end



