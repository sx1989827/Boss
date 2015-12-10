//
//  WGBUtil.m
//  wg-buyer
//
//  Created by Apple on 15/1/21.
//  Copyright (c) 2015年 WeiGuang. All rights reserved.
//

#import "Util.h"
#import <SVProgressHUD.h>
#import "AppDelegate.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
NSString *serverUrl=@"http://123.57.77.6:3000";
//NSString *serverUrl=@"http://192.168.199.154:3000";
//NSString *serverUrl=@"http://192.168.31.155:3000";
//NSString *serverUrl=@"http://localhost:3000";
NSString *msgUpdateLevel=@"msgUpdateLevel";
@implementation Util
/// 获得设备号
+ (NSString *)getIdentifierForVendor
{
    NSUUID *uid = [[UIDevice currentDevice] identifierForVendor];
    return [uid UUIDString];
}

/// 获取caches目录下文件夹路径
+ (NSString *)getCachesPath:(NSString *)directoryName
{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [cachesDirectory stringByAppendingPathComponent:directoryName];
}

/// 获得缓存文件夹路径
+ (NSString *)getCachesDirPath:(NSString *)cachesDir
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageDir = [NSString stringWithFormat:@"%@/Caches/%@/", libraryDirectory, cachesDir];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if (!(isDir == YES && existed == YES))
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imageDir;
}

/// data json解析
+ (id)getSerializationData:(NSData *)data
{
    id result = nil;
    if (data != nil) {
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    return result;
}


/// 获得文字的尺寸
+ (CGSize)getContentSize:(NSString *)content withCGSize:(CGSize)size withSystemFontOfSize:(int)font
{
    CGRect contentBounds = [content boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font]
                                                                                     forKey:NSFontAttributeName]
                                                 context:nil];
    return contentBounds.size;
}

+ (void) getWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud
{
    if(bHud)
    {
         [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval=20;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manage GET:[serverUrl stringByAppendingString:urlStr] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if(blockSucess!=nil)
         {
             NSString *responseString=operation.responseString;
             NSDictionary *data = [responseString parseJson];
             blockSucess(data);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if (blockFail != nil) {
             blockFail(error);
         }
     }];
    
}


+ (void) postWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud
{
    if(bHud)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval=20;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manage POST:[serverUrl stringByAppendingString:urlStr] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if(blockSucess!=nil)
         {
             NSString *responseString=operation.responseString;
             NSDictionary *data = [responseString parseJson];
             blockSucess(data);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if (blockFail != nil) {
             blockFail(error);
         }
     }];

}

+ (void) postWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params BodyBlock:(void (^)(id<AFMultipartFormData> formData))blockBody SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud
{
    if(bHud)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval=20;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manage POST:[serverUrl stringByAppendingString:urlStr] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        blockBody(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if(blockSucess!=nil)
         {
             NSString *responseString=operation.responseString;
             NSDictionary *data = [responseString parseJson];
             blockSucess(data);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if (blockFail != nil) {
             blockFail(error);
         }
     }];
    
}


+ (void) putWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud
{
    if(bHud)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval=20;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manage PUT:[serverUrl stringByAppendingString:urlStr] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if(blockSucess!=nil)
         {
             NSString *responseString=operation.responseString;
             NSDictionary *data = [responseString parseJson];
             blockSucess(data);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if (blockFail != nil) {
             blockFail(error);
         }
     }];

}

+ (void) deleteWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params SuccessBlock:(void (^)(NSDictionary* dic))blockSucess FailBlock:(void (^)(NSError *error))blockFail ShowHud:(BOOL)bHud
{
    if(bHud)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval=20;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manage DELETE:[serverUrl stringByAppendingString:urlStr] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if(blockSucess!=nil)
         {
             NSString *responseString=operation.responseString;
             NSDictionary *data = [responseString parseJson];
             blockSucess(data);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(bHud)
         {
             [SVProgressHUD dismiss];
         }
         if (blockFail != nil) {
             blockFail(error);
         }
     }];

}


+ (UIViewController*)topViewController {
    return [Util topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [Util topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [Util topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [Util topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
@end


@implementation UIViewController (PushView)


-(UIViewController*)pushViewController:(NSString *)ToView Param:(NSDictionary *)param
{
    Class cls=NSClassFromString(ToView);
    id viewController=[[[cls class] alloc] init];
    if(param!=nil)
    {
        for(NSString *key in param)
        {
            id obj=param[key];
            [viewController setValue:obj forKey:key];
        }
    }
    ((UIViewController*)viewController).hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
    return viewController;
}

-(UIViewController*)presentViewController:(NSString *)ToView Param:(NSDictionary*)param
{
    Class cls=NSClassFromString(ToView);
    UIViewController* viewController=[[[cls class] alloc] init];
    if(param!=nil)
    {
        for(NSString *key in param)
        {
            id obj=param[key];
            [viewController setValue:obj forKey:key];
        }
    }
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:nil];
    return viewController;
}

-(void)dismiss
{
    UIImage *img=[[UIApplication sharedApplication].keyWindow image];
    UIImageView *view=[[UIImageView alloc] initWithImage:img];
    view.frame=[UIScreen mainScreen].bounds;
    view.layer.zPosition=FLT_MAX;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        view.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

-(void)flipToView:(UIView*)view
 {
     UIImage *img=[[UIApplication sharedApplication].keyWindow image];
     UIImageView *v=[[UIImageView alloc] initWithImage:img];
     v.frame=[UIScreen mainScreen].bounds;
     v.layer.zPosition=FLT_MAX;
     [[UIApplication sharedApplication].keyWindow addSubview:v];
     [UIView transitionFromView:v toView:view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
         [v removeFromSuperview];
     }];
}
@end

@implementation NSString (Extensin)

- (NSString *) md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *) trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL) isEmpty
{
    return self.length == 0;
}

- (NSDictionary *) parseJson
{
    NSData *da= [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:da options:NSJSONReadingMutableLeaves error:&error];
    return data;
}

-(BOOL)isMobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    NSString * MOBILE = @"^1\\d{10}$";
    
    // 移动
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    
    // 联通
//    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    
    // 电信
//    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}
@end

@implementation UIImage (RoundRectImage)
void addRoundRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                        float ovalHeight){
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0){
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (UIImage *)roundRectWithRadius:(NSInteger)r{
    int w = self.size.width;
    int h = self.size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}
@end

@implementation UIView (Additions)
-(UIViewController *)viewController
{
    UIViewController *vc=nil;
    for(id response=self;response;response=[response nextResponder])
    {
        if([response isKindOfClass:[UIViewController class]])
        {
            vc=response;
            break;
        }
    }
    return vc;
}

-(UIImage*)image
{
        UIGraphicsBeginImageContext(self.bounds.size);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
}

@end

@implementation NSDictionary (WG)

-(NSString*)json
{
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end

@implementation UIButton (Text)
-(NSString*)text
{
    NSString *str=[self titleForState:UIControlStateNormal];
    if(str==nil)
    {
        str=@"";
    }
    return str;
}

-(void)setText:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
}

@end

@implementation NSDate (String)

-(NSString*)stringValue
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    NSString *strTime=[NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    return strTime;
}

@end






