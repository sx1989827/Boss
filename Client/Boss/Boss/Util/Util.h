//
//  WGBUtil.h
//  wg-buyer
//
//  Created by Apple on 15/1/21.
//  Copyright (c) 2015年 WeiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
extern NSString *serverUrl;
@interface UIViewController(PushView)
-(UIViewController*)pushViewController:(NSString *)ToView Param:(NSDictionary*)param;
-(UIViewController*)presentViewController:(NSString *)ToView Param:(NSDictionary*)param;
@end
@interface NSString (Extensin)
- (NSString *) md5;
- (NSString *) trim;
- (BOOL) isEmpty;
- (NSDictionary *) parseJson;
- (BOOL)isMobileNumber;
@end
@interface Util : NSObject

/// 获得设备号
+ (NSString *)getIdentifierForVendor;

/// 获取caches目录下文件夹路径
+ (NSString *)getCachesPath:(NSString *)directoryName;

/// 获得缓存文件夹路径
+ (NSString *)getCachesDirPath:(NSString *)cachesDir;

/// data json解析
+ (id)getSerializationData:(NSData *)data;

/// 获得文字的尺寸
+ (CGSize)getContentSize:(NSString *)content withCGSize:(CGSize)size withSystemFontOfSize:(int)font;
+ (void) getWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud;
+ (void) postWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud;
+ (void) postWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params BodyBlock:(void (^)(id<AFMultipartFormData> formData))blockBody SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud;
+ (void) putWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud;
+ (void) deleteWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud;

+(UIViewController*)topViewController;
+ (NSString *)getCurrentDeviceModel;
@end

@interface UIImage (RoundRectImage)
- (UIImage *)roundRectWithRadius:(NSInteger)r;
@end

@interface UIView (Additions)
-(UIViewController *)viewController;
@end

@interface NSDictionary (WG)
-(NSString*)json;
@end

@interface UIButton (Text)
@property (strong,nonatomic) NSString *text;
@end





