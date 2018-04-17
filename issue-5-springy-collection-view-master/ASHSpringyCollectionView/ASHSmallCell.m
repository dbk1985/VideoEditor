//
//  ASHSmallMarkCell.m
//  ASHSpringyCollectionView
//
//  Created by wzkj on 2018/4/17.
//  Copyright © 2018年 Ash Furrow. All rights reserved.
//

#import "ASHSmallCell.h"

@interface ASHSmallMarkCell()
@property (nonatomic, weak) UIView *lineView;
@end

@implementation ASHSmallMarkCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        self.lineView = line;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect lineFrame = self.lineView.frame;
    lineFrame.origin.x = 0;
    lineFrame.origin.y = CGRectGetHeight(self.frame) * 2 / 3;
    lineFrame.size.width = CGRectGetWidth(self.frame);
    lineFrame.size.height = CGRectGetHeight(self.frame)/3 - 2;
    self.lineView.frame = lineFrame;
}

@end

@implementation ASHBigMarkCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect lineFrame = self.lineView.frame;
    lineFrame.origin.x = 0;
    lineFrame.origin.y = CGRectGetHeight(self.frame) / 3;
    lineFrame.size.width = CGRectGetWidth(self.frame);
    lineFrame.size.height = CGRectGetHeight(self.frame) * 2 / 3 - 2;
    self.lineView.frame = lineFrame;
}
@end

@implementation ASHLargerMarkCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect lineFrame = self.lineView.frame;
    lineFrame.origin.x = 0;
    lineFrame.origin.y = 2;
    lineFrame.size.width = CGRectGetWidth(self.frame);
    lineFrame.size.height = CGRectGetHeight(self.frame) - 2 - 2;
    self.lineView.frame = lineFrame;
}
@end
