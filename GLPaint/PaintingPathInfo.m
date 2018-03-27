//
//  PaintingPathInfo.m
//  GLPaint
//
//  Created by wzkj on 2018/3/27.
//

#import "PaintingPathInfo.h"

@implementation PaintingPathInfo
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.pointsInPath = [NSMutableArray array];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    PaintingPathInfo *model = [[[self class] allocWithZone:zone] init];
    model.pointsInPath= self.pointsInPath;
    model.r  = self.r;
    model.g = self.g;
    model.b = self.b;
    model.a = self.a;
    model.brushScale = self.brushScale;
    return model;
}
@end
