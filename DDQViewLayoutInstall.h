//
//  DDQViewLayoutInstall.h
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/7/11.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQViewLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQLayoutDirection) {
    
    DDQLayoutOrigin = 0,
    DDQLayoutLeftToRight,
    DDQLayoutRightToLeft,
    DDQLayoutTopToBottom,
    DDQLayoutBottomToTop,
    DDQLayoutCenterX,
    DDQLayoutCenterY,
    DDQLayoutCenter,
    
};

typedef NS_ENUM(NSUInteger, DDQLayoutStatus) {
    
    DDQLayoutStatusNone = 0,
    DDQLayoutStatusX,
    DDQLayoutStatusY,
    DDQLayoutStatusWidth,
    DDQLayoutStatusHeight,
    DDQLayoutStatusCenter,
    
};

struct DDQLayoutCenterOffset {
    
    CGFloat xOffset; //x坐标偏移量
    CGFloat yOffset; //y坐标偏移量
    
};
typedef struct DDQLayoutCenterOffset DDQLayoutCenterOffset;

UIKIT_EXTERN const DDQLayoutCenterOffset DDQLayoutCenterOffsetZero;

UIKIT_STATIC_INLINE DDQLayoutCenterOffset DDQLayoutCenterOffsetMaker(CGFloat x, CGFloat y);

@interface DDQViewLayoutInstall : NSObject

- (instancetype)initWithView:(UIView *)view NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, CGFloat value))top;
- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, CGFloat value))left;
- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, CGFloat value))bottom;
- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, CGFloat value))right;
- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, CGFloat value))centerX;
- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, CGFloat value))centerY;
- (DDQViewLayoutInstall * (^)(DDQAutoLayoutProperty *_Nullable property, DDQLayoutCenterOffset offset))center;

/**
 这个方法是用在你单独修改控件的x,y后，用来更正整体的frame。
 */
- (void(^)(void))update;

- (void(^)(void))sizeToFit;
- (void(^)(CGFloat scale))sizeToFitForScale;
- (void(^)(CGSize size))sizeThatFits;
- (void(^)(CGSize size, CGFloat scale))sizeThatFitsForScale;
- (void(^)(CGSize size))size;
- (void(^)(CGFloat width))width;
- (void(^)(CGFloat height))height;

- (void(^)(UIView *_Nullable view, UIEdgeInsets insets))insets;

- (void)uninstall;

@property (nonatomic, assign, readonly) DDQLayoutDirection horDirection;
@property (nonatomic, assign, readonly) DDQLayoutDirection verDirection;

@property (nonatomic, assign, readonly) DDQLayoutStatus xStatus;
@property (nonatomic, assign, readonly) DDQLayoutStatus yStatus;
@property (nonatomic, assign, readonly) DDQLayoutStatus widthStatus;
@property (nonatomic, assign, readonly) DDQLayoutStatus heightStatus;

@end

UIKIT_STATIC_INLINE DDQLayoutCenterOffset DDQLayoutCenterOffsetMaker(CGFloat x, CGFloat y) {
    
    DDQLayoutCenterOffset offset; offset.xOffset = x; offset.yOffset = y; return offset;
    
}

NS_ASSUME_NONNULL_END
