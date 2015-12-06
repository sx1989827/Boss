//
//  TextDrawView.h
//  iOSTest
//
//  Created by 孙昕 on 15/9/4.
//  Copyright (c) 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextDrawView : UIView
-(void)addText:(NSString*)text Style:(NSDictionary*)dic ClickBlock:(BOOL (^)(NSMutableAttributedString *str,NSInteger start,NSInteger len))block;
-(void)addNewLine;
-(void)addImage:(NSString*)name Width:(CGFloat)width Height:(CGFloat)height  ClickBlock:(void (^)())block;
-(void)setDrawInset:(CGFloat)left Top:(CGFloat)top;
-(void)clear;
@end
