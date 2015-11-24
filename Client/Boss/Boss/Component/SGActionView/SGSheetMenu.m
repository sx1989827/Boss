//
//  SGSheetMenu.m
//  SGActionView
//
//  Created by Sagi on 13-9-6.
//  Copyright (c) 2013年 AzureLab. All rights reserved.
//

#import "SGSheetMenu.h"
#import <QuartzCore/QuartzCore.h>

#define kMAX_SHEET_TABLE_HEIGHT   400

@interface SGSheetMenu () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *subItems;

@property (nonatomic, strong) void(^actionHandle)(NSInteger);
@end

@implementation SGSheetMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BaseMenuBackgroundColor(self.style);

        _selectedItemIndex = NSIntegerMax;
        _items = [NSArray array];
        _subItems = [NSArray array];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = BaseMenuTextColor(self.style);
        [self addSubview:_titleLabel];
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self addSubview:_tableView];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        _tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
        [self setupWithTitle:title items:itemTitles subItems:nil];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles subTitles:(NSArray *)subTitles
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self setupWithTitle:title items:itemTitles subItems:subTitles];
    }
    return self;
}

- (void)setupWithTitle:(NSString *)title items:(NSArray *)items subItems:(NSArray *)subItems;
{
    _titleLabel.text = title;
    _items = items;
    _subItems = subItems;
}

- (void)setStyle:(SGActionViewStyle)style{
    _style = style;
    
    self.backgroundColor = BaseMenuBackgroundColor(style);
    self.titleLabel.textColor = BaseMenuTextColor(style);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float height = 0;
    float table_top_margin = 0;
    float table_bottom_margin = 10;
    
    self.titleLabel.frame = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, 40)};
    height += self.titleLabel.bounds.size.height;
    height += table_top_margin;
    
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    float contentHeight = self.tableView.contentSize.height;
    if (contentHeight > kMAX_SHEET_TABLE_HEIGHT) {
        contentHeight = kMAX_SHEET_TABLE_HEIGHT;
        self.tableView.scrollEnabled = YES;
    }else{
        self.tableView.scrollEnabled = NO;
    }
    self.tableView.frame = CGRectMake(self.bounds.size.width * 0.05, height, self.bounds.size.width * 0.9, contentHeight);
    height += self.tableView.bounds.size.height;
    
    height += table_bottom_margin;
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, height)};
}

#pragma mark - 

- (void)triggerSelectedAction:(void (^)(NSInteger))actionHandle
{
    self.actionHandle = actionHandle;
}

#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.subItems.count > 0) {
        return 60;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = BaseMenuTextColor(self.style);
        cell.detailTextLabel.textColor = BaseMenuTextColor(self.style);
        UIImageView *lb=[[UIImageView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width-20, 15, 20, 20)];
        lb.contentMode=UIViewContentModeScaleAspectFit;
        lb.tag=100;
        lb.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
        [cell.contentView addSubview:lb];
    }
    cell.textLabel.text = self.items[indexPath.row];
    if (self.subItems.count > indexPath.row) {
        NSString *subTitle = self.subItems[indexPath.row];
        if (![subTitle isEqual:[NSNull null]]) {
            cell.detailTextLabel.text = subTitle;
        }
    }
    UIImageView *lb=(UIImageView*)[cell.contentView viewWithTag:100];
    if (self.selectedItemIndex == indexPath.row) {
        lb.image=[UIImage imageNamed:@"cellcheck.png"];
    }else{
        lb.image=nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.selectedItemIndex != indexPath.row) {
//        self.selectedItemIndex = indexPath.row;
//        [tableView reloadData];
//    }
    if (self.actionHandle) {
        double delayInSeconds = 0.15;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.actionHandle(indexPath.row);
        });
    }
}

@end
