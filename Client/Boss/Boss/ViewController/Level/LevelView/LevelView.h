//
//  LevelView.h
//  Boss
//
//  Created by 孙昕 on 15/11/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LevelViewDelegate<NSObject>
-(void)LevelViewClick:(NSInteger)index Text:(NSString*)text;
@end
@interface LevelView : UIScrollView
-(instancetype)initWithNodes:(NSArray*)nodes UserIndex:(NSInteger)indexUser MaxCount:(NSInteger)maxCount;
-(BOOL)updateUser:(NSString*)nextText;
@property (weak,nonatomic) id<LevelViewDelegate> delegateNode;
@end
