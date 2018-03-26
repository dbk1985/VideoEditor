//
//  DLSlowCommond.m
//  AVPlayer_2
//
//  Created by wzkj on 2018/3/26.
//  Copyright © 2018年 hubino. All rights reserved.
//

#import "DLSlowCommond.h"

@implementation DLSlowCommond
- (void)performWithAsset:(AVAsset *)asset
{

    AVAssetTrack *assetVideoTrack = nil;
    AVAssetTrack *assetAudioTrack = nil;
    // Check if the asset contains video and audio tracks
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
        assetVideoTrack = [asset tracksWithMediaType:AVMediaTypeVideo][0];
    }
    if ([[asset tracksWithMediaType:AVMediaTypeAudio] count] != 0) {
        assetAudioTrack = [asset tracksWithMediaType:AVMediaTypeAudio][0];
    }

    CMTime insertionPoint = kCMTimeZero;
    NSError *error = nil;

    if (!self.mutableComposition) {
        self.mutableComposition = [AVMutableComposition composition];
        // Insert the video and audio tracks from AVAsset
        if (assetVideoTrack != nil) {
            AVMutableCompositionTrack *compositionVideoTrack = [self.mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
            [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset duration]) ofTrack:assetVideoTrack atTime:insertionPoint error:&error];
        }
        if (assetAudioTrack != nil) {
            AVMutableCompositionTrack *compositionAudioTrack = [self.mutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
            [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset duration]) ofTrack:assetAudioTrack atTime:insertionPoint error:&error];
        }
    }

    CMTime assetTime = [asset duration];
    CGFloat assetDuration = CMTimeGetSeconds(assetTime);

    CGFloat fastRate = 0.3;//fastMotionRate; //比如3.0倍加速
    CGFloat timeScale = asset.duration.timescale;
    //NSError *error = nil;
    // 这里的startTime和endTime都是秒，需要乘以timeScale来组成CMTime
    CMTime startTime = CMTimeMake(/*self.fastStartTime*/0 * timeScale, timeScale);
    CMTime duration = CMTimeMake((/*self.fastEndTime - self.fastStartTime*/floor(assetDuration)) * timeScale, timeScale);
    CMTimeRange fastRange = CMTimeRangeMake(startTime, duration);
    CMTime scaledDuration = CMTimeMake(duration.value / fastRate, timeScale);

    // 处理视频轨
    [[self.mutableComposition tracksWithMediaType:AVMediaTypeVideo] enumerateObjectsUsingBlock:^(AVMutableCompositionTrack * _Nonnull videoTrack, NSUInteger idx, BOOL * _Nonnull stop) {
        [videoTrack scaleTimeRange:fastRange toDuration:scaledDuration];
    }];

    // 处理音频轨
    [[self.mutableComposition tracksWithMediaType:AVMediaTypeAudio] enumerateObjectsUsingBlock:^(AVMutableCompositionTrack * _Nonnull audioTrack, NSUInteger idx, BOOL * _Nonnull stop) {
        // 这里需要注意，如果音频和视频的timescale不一致，那么这里需要重新计算音频需要裁剪的区间，否则会出现音频视频裁剪区间错位的问题
        [audioTrack removeTimeRange:fastRange]; //消音
    }];

    [[NSNotificationCenter defaultCenter] postNotificationName:AVSEEditCommandCompletionNotification object:self];
}
@end
