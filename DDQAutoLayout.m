//
//  DDQAutoLayout.m
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/3/19.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQAutoLayout.h"

#import "UIView+DDQViewLayout.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, DDQAutoLayoutOriginPoint) {
    
    DDQAutoLayoutOriginPointFromTop,
    DDQAutoLayoutOriginPointFromBottom,
    DDQAutoLayoutOriginPointFromLeft,
    DDQAutoLayoutOriginPointFromRight,
    DDQAutoLayoutOriginPointFromCenterX,
    DDQAutoLayoutOriginPointFromCenterY,
    DDQAutoLayoutOriginPointFromCenter,
    
};

@interface DDQAutoLayout ()

@property (nonatomic, strong) UIView *targetView;

@end

@implementation DDQAutoLayout

- (instancetype)initAutoLayoutWithView:(__kindof UIView *)view {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.targetView = view;
    
    return self;
    
}

#pragma mark - View Point Config
- (DDQAutoLayoutLeft)DDQLeft {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property, CGFloat constraint) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromLeft property:property constraint:constraint view:self.targetView];
        return self;
        
    };
}

- (DDQAutoLayoutRight)DDQRight {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property, CGFloat constraint) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromRight property:property constraint:constraint view:self.targetView];
        
        return self;
        
    };
}

- (DDQAutoLayoutTop)DDQTop {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property, CGFloat constraint) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromTop property:property constraint:constraint view:self.targetView];
        return self;
        
    };
}

- (DDQAutoLayoutBottom)DDQBottom {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property, CGFloat constraint) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromBottom property:property constraint:constraint view:self.targetView];
        return self;
        
    };
}

- (DDQAutoLayoutCenterX)DDQCenterX {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property, CGFloat constraint) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromCenterX property:property constraint:constraint view:self.targetView];
        return self;
        
    };
}

- (DDQAutoLayoutCenterY)DDQCenterY {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property, CGFloat constraint) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromCenterY property:property constraint:constraint view:self.targetView];
        return self;
        
    };
}

- (DDQAutoLayoutCenter)DDQCenter {
    
    return ^DDQAutoLayout *(DDQAutoLayoutProperty *property) {
        
        [self layout_handleViewOriginPoint:DDQAutoLayoutOriginPointFromCenter property:property constraint:0.0 view:self.targetView];
        return self;
        
    };
}

#pragma mark - View Size Config
- (DDQAutoLayoutInsets)DDQInsets {
    
    return ^void (__kindof UIView *view, UIEdgeInsets insets) {
        
        CGFloat x = insets.left;
        CGFloat y = insets.top;
        CGFloat w = CGRectGetWidth(view.frame) - insets.left - insets.right;
        CGFloat h = CGRectGetHeight(view.frame) - insets.top - insets.bottom;
        if (![view isEqual:self.targetView.superview]) {
            
            x += CGRectGetMinX(view.frame);
            y += CGRectGetMinY(view.frame);
        }
        self.targetView.frame = CGRectMake(x, y, w, h);
        
    };
}

- (DDQAutoLayoutWidth)DDQWidth {
    
    return ^void (CGFloat width) {
        
        CGRect targetFrame = self.targetView.frame;
        targetFrame.size.width = width;
        [self layout_handleViewFrameWithNewSize:targetFrame.size view:self.targetView];
        
    };
}

- (DDQAutoLayoutHeight)DDQHeight {
    
    return ^void (CGFloat height) {
        
        CGRect targetFrame = self.targetView.frame;
        targetFrame.size.height = height;
        [self layout_handleViewFrameWithNewSize:targetFrame.size view:self.targetView];
        
    };
}

- (DDQAutoLayoutSize)DDQSize {
    
    return ^void (CGSize size) {
        
        [self layout_handleViewFrameWithNewSize:size view:self.targetView];
        
    };
}

- (DDQAutoLayoutEstimateSize)DDQEstimateSize {
    
    return ^void (CGSize size) {
        
        CGSize boundSize = [self.targetView sizeThatFits:size];
        
        //        if (boundSize.height > size.height) {
        //
        //            boundSize.height = size.height;
        //
        //        }
        [self layout_handleViewFrameWithNewSize:boundSize view:self.targetView];
        
    };
}

- (DDQAutoLayoutFitViewSize)DDQFitSize {
    
    return ^void () {
        
        [self.targetView sizeToFit];
        [self layout_handleViewFrameWithNewSize:self.targetView.frame.size view:self.targetView];
        
    };
}

- (DDQAutoLayoutFitViewScaleSize)DDQScaleFitSize {
    
    return ^void (CGFloat scale) {
        
        [self.targetView sizeToFit];
        [self layout_handleViewFrameWithNewSize:CGSizeMake(CGRectGetWidth(self.targetView.frame) * scale, CGRectGetHeight(self.targetView.frame) * scale) view:self.targetView];
        
    };
}

#pragma mark - View Handler
/**
 集中处理view的origin
 
 @param point 处理的类型
 @param property 布局的属性
 @param constraint 布局的间距
 */
- (void)layout_handleViewOriginPoint:(DDQAutoLayoutOriginPoint)point property:(DDQAutoLayoutProperty *)property constraint:(CGFloat)constraint view:(UIView *)view {
    
    CGRect targetFrame = view.frame;
    CGPoint targetOrigin = targetFrame.origin;
    switch (point) {
            
        case DDQAutoLayoutOriginPointFromTop:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            targetOrigin.y += constraint;
            self.targetView.verDirection = DDQAutoLayoutDirectionTTB;
            
        }break;
            
        case DDQAutoLayoutOriginPointFromLeft:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            targetOrigin.x += constraint;
            self.targetView.horDirection = DDQAutoLayoutDirectionLTR;
            
        } break;
            
        case DDQAutoLayoutOriginPointFromRight:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            targetOrigin.x -= constraint;
            self.targetView.horDirection = DDQAutoLayoutDirectionRTL;
            
        } break;
            
        case DDQAutoLayoutOriginPointFromBottom:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            targetOrigin.y -= constraint;
            self.targetView.verDirection = DDQAutoLayoutDirectionBTT;
            
        } break;
            
        case DDQAutoLayoutOriginPointFromCenter:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            self.targetView.verDirection = DDQAutoLayoutDirectionCenter;
            self.targetView.horDirection = DDQAutoLayoutDirectionCenter;
            
        } break;
            
        case DDQAutoLayoutOriginPointFromCenterX:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            targetOrigin.x += constraint;
            self.targetView.horDirection = DDQAutoLayoutDirectionCenterX;
            
        } break;
            
        case DDQAutoLayoutOriginPointFromCenterY:{
            
            targetOrigin = [self layout_handleViewOriginWithProperty:property];
            targetOrigin.y += constraint;
            self.targetView.verDirection = DDQAutoLayoutDirectionCenterY;
            
        } break;
            
        default:
            break;
            
    }
    targetFrame.origin = targetOrigin;
    view.frame = targetFrame;
    
    if (!CGSizeEqualToSize(view.frame.size, CGSizeZero)) {
        
        targetFrame.origin = [self layout_handleViewOriginWithSize:targetFrame.size view:view];
        view.frame = targetFrame;

    }
}

/**
 根据不同的布局属性样式重新确定起始坐标
 
 @param p 自定义布局属性
 @return 新的起始坐标
 */
- (CGPoint)layout_handleViewOriginWithProperty:(DDQAutoLayoutProperty *)p {
    
    CGPoint newPoint = self.targetView.frame.origin;
    DDQLayoutProperty property = p.property;
    if (property == DDQLayoutPropertyLeft) {
        
        newPoint.x = (p.view == self.targetView.superview) ? 0.0 : CGRectGetMinX(p.view.frame);
        
    } else if (property == DDQLayoutPropertyTrailing) {
        
        newPoint.x = (p.view == self.targetView.superview) ? CGRectGetWidth(p.view.frame) : CGRectGetMaxX(p.view.frame);
        
    } else if (property == DDQLayoutPropertyCenterX) {
        
        newPoint.x = (p.view == self.targetView.superview) ? CGRectGetMidX(p.view.bounds) : CGRectGetMaxX(p.view.frame);
        
    } else if (property == DDQLayoutPropertyTop) {
        
        newPoint.y = (p.view == self.targetView.superview) ? 0.0 : CGRectGetMinY(p.view.frame);
        
    } else if (property == DDQLayoutPropertyBottom) {
        
        newPoint.y = (p.view == self.targetView.superview) ? CGRectGetHeight(p.view.frame) : CGRectGetMaxY(p.view.frame);
        
    } else if (property == DDQLayoutPropertyCenterY) {
        
        newPoint.y = (p.view == self.targetView.superview) ? CGRectGetMidY(p.view.bounds) : CGRectGetMidY(p.view.frame);
        
    } else if (property == DDQLayoutPropertyCenter) {
        
        newPoint = (p.view == self.targetView.superview) ? CGPointMake(CGRectGetMidX(p.view.bounds), CGRectGetMidY(p.view.bounds)) : CGPointMake(CGRectGetMidX(p.view.frame), CGRectGetMidY(p.view.frame));
        
    }
    return newPoint;
    
}

/**
 处理view的frame
 
 @param size 新赋值的size
 */
- (void)layout_handleViewFrameWithNewSize:(CGSize)size view:(UIView *)view {
    
    CGRect targetFrame = view.frame;
    targetFrame.size = size;
    targetFrame.origin = [self layout_handleViewOriginWithSize:size view:view];
    
    self.targetView.frame = targetFrame;
    
}

/**
 修改应为size变化而导致的origin变化
 
 @param size 新的大小
 @return 新的其实坐标
 */
- (CGPoint)layout_handleViewOriginWithSize:(CGSize)size view:(UIView *)view {
    
    CGRect targetFrame = view.frame;
    CGPoint targetOrigin = targetFrame.origin;
    switch (self.targetView.horDirection) {
            
        case DDQAutoLayoutDirectionRTL:
            
            targetOrigin.x -= size.width;
            
            break;
            
        case DDQAutoLayoutDirectionCenterX:
            
            targetOrigin.x -= size.width * 0.5;
            
            break;
            
        case DDQAutoLayoutDirectionCenter:
            
            targetOrigin.x -= size.width * 0.5;
            
            break;
            
            
        default:
            break;
            
    }
    
    switch (self.targetView.verDirection) {
            
        case DDQAutoLayoutDirectionBTT:
            
            targetOrigin.y -= size.height;
            
            break;
            
        case DDQAutoLayoutDirectionCenterY:
            
            targetOrigin.y -= size.height * 0.5;
            
            break;
            
        case DDQAutoLayoutDirectionCenter:
            
            targetOrigin.y -= size.height * 0.5;
            
            break;
            
            
        default:
            break;
    }
    
    return targetOrigin;
    
}


@end

@implementation UIView (DDQViewAutoLayoutDirection)

static const char *HorDirection = "Horizontal";
static const char *VerDirection = "Vertical";

- (void)setHorDirection:(DDQAutoLayoutDirection)horDirection {
    
    objc_setAssociatedObject(self, HorDirection, @(horDirection), OBJC_ASSOCIATION_RETAIN);
    
}

- (DDQAutoLayoutDirection)horDirection {
    
    return [objc_getAssociatedObject(self, HorDirection) integerValue];
    
}

- (void)setVerDirection:(DDQAutoLayoutDirection)verDirection {
    
    objc_setAssociatedObject(self, VerDirection, @(verDirection), OBJC_ASSOCIATION_RETAIN);
    
}

- (DDQAutoLayoutDirection)verDirection {
    
    return [objc_getAssociatedObject(self, VerDirection) integerValue];
    
}

@end
