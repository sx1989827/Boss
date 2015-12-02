//
//  TipView.h
//  Boss
//
//  Created by 孙昕 on 15/11/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipView : UIVisualEffectView
+(void)showWithTitle:(NSString*)title Tip:(NSString*)text Block:(void (^)())block;
+(void)showWithTitle:(NSString*)title Tip:(NSString*)text YesBlock:(void (^)())blockYes  NoBlock:(void (^)())blockNo;
@end
