//
//  ViewGameProtovol.h
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#ifndef ViewGameProtovol_h
#define ViewGameProtovol_h

@protocol ViewGameDelegate<NSObject>
-(void)over:(BOOL)bWin UseTime:(NSInteger)useTime Score:(NSInteger)score;
@end
#endif /* ViewGameProtovol_h */
