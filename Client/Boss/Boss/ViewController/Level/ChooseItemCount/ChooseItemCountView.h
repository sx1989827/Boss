//
//  ChooseItemCountView.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseItemCountDelegate<NSObject>
-(BOOL)ChooseItemCountAdd;
@end
@interface ChooseItemCountView : UIView
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbCount;
- (IBAction)onAdd:(id)sender;
- (IBAction)onMinus:(id)sender;
@property (weak,nonatomic) id<ChooseItemCountDelegate> delegate;
@end
