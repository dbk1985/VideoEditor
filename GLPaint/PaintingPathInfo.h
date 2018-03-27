//
//  PaintingPathInfo.h
//  GLPaint
//
//  Created by wzkj on 2018/3/27.
//

#import <Foundation/Foundation.h>

@interface PaintingPathInfo : NSObject<NSCopying>
@property (nonatomic, strong) NSMutableArray *pointsInPath;
@property (nonatomic, assign) CGFloat r;
@property (nonatomic, assign) CGFloat g;
@property (nonatomic, assign) CGFloat b;
@property (nonatomic, assign) CGFloat a;
@property (nonatomic, assign) CGFloat brushScale;

@end
