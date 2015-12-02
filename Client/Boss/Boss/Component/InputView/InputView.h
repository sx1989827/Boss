//
//  InputView.h
//  Boss
//
//  Created by 孙昕 on 15/11/25.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIVisualEffectView
+(void)showWithTitle:(NSString*)title TextPlaceHolder:(NSString*)placeholder Block:(BOOL (^)(NSString *text))block;
@end
