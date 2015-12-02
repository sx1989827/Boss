//
//  RankCell.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "RankCell.h"
#import "RankItem.h"
#import "Header.h"
@implementation RankCell
-(NSNumber*)LazyTableCellHeight:(id)item Path:(NSIndexPath *)path
{
    return @70;
}

-(void)LazyTableCellForRowAtIndexPath:(id)item Path:(NSIndexPath *)path
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    RankItem *data=item;
    _lbName.text=data.name;
    _lbScore.text=[NSString stringWithFormat:@"%ld",data.score];
    [_imgPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",serverUrl,data.photo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _imgPhoto.layer.masksToBounds=YES;
    _imgPhoto.layer.cornerRadius=5;
}

@end





