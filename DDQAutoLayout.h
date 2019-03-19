//
//  DDQAutoLayout.h
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/3/19.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQViewLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class DDQAutoLayout;

typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutLeft)(DDQAutoLayoutProperty *_Nullable property, CGFloat constraint);
typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutTop)(DDQAutoLayoutProperty *_Nullable property, CGFloat constraint);
typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutBottom)(DDQAutoLayoutProperty *_Nullable property, CGFloat constraint);
typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutRight)(DDQAutoLayoutProperty *_Nullable property, CGFloat constraint);
typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutCenter)(DDQAutoLayoutProperty *_Nullable property);
typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutCenterX)(DDQAutoLayoutProperty *_Nullable property, CGFloat constraint);
typedef DDQAutoLayout *_Nonnull(^DDQAutoLayoutCenterY)(DDQAutoLayoutProperty *_Nullable property, CGFloat constraint);

typedef void(^DDQAutoLayoutInsets)(__kindof UIView *view, UIEdgeInsets insets);
typedef void(^DDQAutoLayoutWidth)(CGFloat width);
typedef void(^DDQAutoLayoutHeight)(CGFloat height);
typedef void(^DDQAutoLayoutSize)(CGSize size);
typedef void(^DDQAutoLayoutEstimateSize)(CGSize size);

typedef void(^DDQAutoLayoutFitViewSize)(void);
typedef void(^DDQAutoLayoutFitViewScaleSize)(CGFloat scale);

UIKIT_STATIC_INLINE DDQAutoLayout *DDQAutoLayoutMaker(__kindof UIView *_Nullable view);

@interface DDQAutoLayout : NSObject

/**
 初始化方法

 @param view 布局的视图
 */
- (instancetype)initAutoLayoutWithView:(nullable __kindof UIView *)view NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) DDQAutoLayoutLeft DDQLeft;
@property (nonatomic, readonly) DDQAutoLayoutRight DDQRight;
@property (nonatomic, readonly) DDQAutoLayoutTop DDQTop;
@property (nonatomic, readonly) DDQAutoLayoutBottom DDQBottom;
@property (nonatomic, readonly) DDQAutoLayoutCenterX DDQCenterX;
@property (nonatomic, readonly) DDQAutoLayoutCenterY DDQCenterY;
@property (nonatomic, readonly) DDQAutoLayoutCenter DDQCenter;

@property (nonatomic, readonly) DDQAutoLayoutInsets DDQInsets;
@property (nonatomic, readonly) DDQAutoLayoutWidth DDQWidth;
@property (nonatomic, readonly) DDQAutoLayoutHeight DDQHeight;
@property (nonatomic, readonly) DDQAutoLayoutSize DDQSize;
@property (nonatomic, readonly) DDQAutoLayoutEstimateSize DDQEstimateSize;
@property (nonatomic, readonly) DDQAutoLayoutFitViewSize DDQFitSize;
@property (nonatomic, readonly) DDQAutoLayoutFitViewScaleSize DDQScaleFitSize;

@end

typedef NS_ENUM(NSUInteger, DDQAutoLayoutDirection) {
    
    DDQAutoLayoutDirectionLTR,          //从左到右
    DDQAutoLayoutDirectionRTL,          //从右到左
    DDQAutoLayoutDirectionTTB,          //从上到下
    DDQAutoLayoutDirectionBTT,          //从下到上
    DDQAutoLayoutDirectionCenter,
    DDQAutoLayoutDirectionCenterX,
    DDQAutoLayoutDirectionCenterY,
    
};

@interface UIView (DDQViewAutoLayoutDirection)

@property (nonatomic, assign) DDQAutoLayoutDirection horDirection;
@property (nonatomic, assign) DDQAutoLayoutDirection verDirection;

@end


UIKIT_STATIC_INLINE DDQAutoLayout *DDQAutoLayoutMaker(__kindof UIView *_Nullable view) {
    
    return [[DDQAutoLayout alloc] initAutoLayoutWithView:view];
    
}

NS_ASSUME_NONNULL_END
