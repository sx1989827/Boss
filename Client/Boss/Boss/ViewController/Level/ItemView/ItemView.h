//
//  ItemView.h
//  Boss
//
//  Created by 孙昕 on 15/12/5.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "TextDrawView.h"
@protocol ItemViewDelegate<NSObject>
-(void)clickQuestion:(NSInteger)index;
-(void)finishQuestion;
@end
@interface ItemView : TextDrawView
-(void)addItem:(NSString*)text Flag:(NSString*)flag;
-(void)setOK:(BOOL)bOk Text:(NSString*)text;
@property (weak,nonatomic) id<ItemViewDelegate> delegate;
@end
