//
//  DDQViewLayoutInstall.m
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/7/11.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQViewLayoutInstall.h"

typedef NS_ENUM(NSUInteger, DDQLayoutInstallType) {
    
    DDQLayoutInstallTop,
    DDQLayoutInstallBottom,
    DDQLayoutInstallLeft,
    DDQLayoutInstallRight,
    DDQLayoutInstallCenterX,
    DDQLayoutInstallCenterY,
    DDQLayoutInstallCenter,

};

@interface DDQViewLayoutInstall ()

@property (nonatomic, strong) UIView *targetView;

@property (nonatomic, assign, readwrite) DDQLayoutDirection horDirection;
@property (nonatomic, assign, readwrite) DDQLayoutDirection verDirection;

@property (nonatomic, assign, readwrite) DDQLayoutStatus xStatus;
@property (nonatomic, assign, readwrite) DDQLayoutStatus yStatus;
@property (nonatomic, assign, readwrite) DDQLayoutStatus widthStatus;
@property (nonatomic, assign, readwrite) DDQLayoutStatus heightStatus;

@end

@implementation DDQViewLayoutInstall

const DDQLayoutCenterOffset DDQLayoutCenterOffsetZero = {0.0, 0.0};

- (instancetype)initWithView:(UIView *)view {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSAssert(view, @"需要布局的视图不能为空");
    self.targetView = view;
    
    return self;
    
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, CGFloat))top {
    
    return ^ DDQViewLayoutInstall * (DDQAutoLayoutProperty *property, CGFloat v) {
        
        [self handleWithInstallType:DDQLayoutInstallTop layoutProperty:property value:v];
        return self;
        
    };
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, CGFloat))left {
    
    return ^ DDQViewLayoutInstall * (DDQAutoLayoutProperty *property, CGFloat v) {
        
        [self handleWithInstallType:DDQLayoutInstallLeft layoutProperty:property value:v];
        return self;
        
    };
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, CGFloat))bottom {
    
    return ^ DDQViewLayoutInstall * (DDQAutoLayoutProperty *property, CGFloat v) {
        
        [self handleWithInstallType:DDQLayoutInstallBottom layoutProperty:property value:v];
        return self;
        
    };
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, CGFloat))right {
    
    return ^ DDQViewLayoutInstall *  (DDQAutoLayoutProperty *property, CGFloat v) {
        
        [self handleWithInstallType:DDQLayoutInstallRight layoutProperty:property value:v];
        return self;
        
    };
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, CGFloat))centerX {
    
    return ^ DDQViewLayoutInstall * (DDQAutoLayoutProperty *property, CGFloat v) {
        
        [self handleWithInstallType:DDQLayoutInstallCenterX layoutProperty:property value:v];
        return self;
        
    };
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, CGFloat))centerY {
    
    return ^ DDQViewLayoutInstall * (DDQAutoLayoutProperty *property, CGFloat v) {
        
        [self handleWithInstallType:DDQLayoutInstallCenterY layoutProperty:property value:v];
        return self;
        
    };
}

- (DDQViewLayoutInstall * _Nonnull (^)(DDQAutoLayoutProperty * _Nullable, DDQLayoutCenterOffset))center {
    
    return ^ DDQViewLayoutInstall * (DDQAutoLayoutProperty *property, DDQLayoutCenterOffset offset) {
        
        [self handleWithInstallType:DDQLayoutInstallCenter layoutProperty:property value:0.0 offset:offset];
        return self;
        
    };
}

- (void (^)(void))update {
    
    return ^ void (void) {
        
        [self handleFinalFrameWithSize:self.targetView.frame.size];
        
    };
}

- (void (^)(void))sizeToFit {
    
    return ^ void (void) {
        
        [self.targetView sizeToFit];
        [self handleFinalFrameWithSize:self.targetView.frame.size];
        
    };
}

- (void (^)(CGSize))sizeThatFits {
    
    return ^ void (CGSize size) {
        
        CGSize fitSize = [self.targetView sizeThatFits:size];
        [self handleFinalFrameWithSize:fitSize];
        
    };
}

- (void (^)(CGSize, CGFloat))sizeThatFitsForScale {
    
    return ^ void (CGSize size, CGFloat scale) {
      
        CGSize fitSize = [self.targetView sizeThatFits:size];
        [self handleFinalFrameWithSize:CGSizeMake(fitSize.width * scale, fitSize.height * scale)];

    };
}

- (void (^)(CGFloat))sizeToFitForScale {
    
    return ^ void (CGFloat scale) {
        
        [self.targetView sizeToFit];
        [self handleFinalFrameWithSize:CGSizeMake(self.targetView.frame.size.width * scale, self.targetView.frame.size.height * scale)];

    };
}

- (void (^)(CGSize))size {
    
    return ^ void (CGSize size) {
        
        [self handleFinalFrameWithSize:size];
        
    };
}

- (void (^)(CGFloat))width {
    
    return ^ void (CGFloat w) {
        
        [self handleFinalFrameWithSize:CGSizeMake(w, self.targetView.frame.size.height)];
        
    };
}

- (void (^)(CGFloat))height {
    
    return ^ void (CGFloat h) {
        
        [self handleFinalFrameWithSize:CGSizeMake(self.targetView.frame.size.width, h)];
        
    };
}

- (void (^)(UIView * _Nullable, UIEdgeInsets))insets {
    
    return ^ void (UIView *view, UIEdgeInsets insets) {
        
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

- (void)uninstall {
    
    self.horDirection = DDQLayoutOrigin;
    self.verDirection = DDQLayoutOrigin;
    
    self.xStatus = DDQLayoutStatusNone;
    self.yStatus = DDQLayoutStatusNone;
    self.widthStatus = DDQLayoutStatusNone;
    self.heightStatus = DDQLayoutStatusNone;
    
}

- (void)handleWithInstallType:(DDQLayoutInstallType)type layoutProperty:(DDQAutoLayoutProperty *)property value:(CGFloat)value {
    
    [self handleWithInstallType:type layoutProperty:property value:value offset:DDQLayoutCenterOffsetZero];
    
}

- (void)handleWithInstallType:(DDQLayoutInstallType)type layoutProperty:(DDQAutoLayoutProperty *)property value:(CGFloat)value offset:(DDQLayoutCenterOffset)offset {
    
    DDQLayoutDirection verDir = self.verDirection;
    DDQLayoutDirection horDir = self.horDirection;
    
    DDQLayoutStatus xStatus = self.xStatus;
    DDQLayoutStatus yStatus = self.yStatus;

    CGRect frame = self.targetView.frame;
    switch (type) {
            
        case DDQLayoutInstallTop:
            
            self.verDirection = verDir != DDQLayoutOrigin ? : DDQLayoutTopToBottom;
            self.yStatus = yStatus != DDQLayoutStatusNone ? : DDQLayoutStatusY;
            
            if (yStatus == DDQLayoutStatusNone) {
                
                CGFloat y = [self getValueWithtProperty:property] + value;
                frame.origin.y = y;
                
            } else {
                
                CGFloat constraint = [self getValueWithtProperty:property] + value;
                frame.size.height = constraint > frame.origin.y ? constraint - frame.origin.y : frame.origin.y - constraint;
                
            }
            break;
            
        case DDQLayoutInstallLeft:
            
            self.horDirection = horDir != DDQLayoutOrigin ? : DDQLayoutLeftToRight;
            self.xStatus = xStatus != DDQLayoutStatusNone ? : DDQLayoutStatusX;
            
            if (xStatus == DDQLayoutStatusNone) {
                
                CGFloat x = [self getValueWithtProperty:property] + value;
                frame.origin.x = x;
                
            } else {
                
                CGFloat constraint = [self getValueWithtProperty:property] + value;
                frame.size.width = constraint > frame.origin.x ? constraint - frame.origin.x : frame.origin.x - constraint;
                
            }
            break;

        case DDQLayoutInstallRight:
            
            self.horDirection = horDir != DDQLayoutOrigin ? : DDQLayoutRightToLeft;
            self.xStatus = xStatus != DDQLayoutStatusNone ? : DDQLayoutStatusX;
            
            if (xStatus == DDQLayoutStatusNone) {
                
                CGFloat x = [self getValueWithtProperty:property] + value;
                frame.origin.x = x;
                
            } else {
                
                CGFloat constraint = [self getValueWithtProperty:property] + value;
                frame.size.width = constraint > frame.origin.x ? constraint - frame.origin.x : frame.origin.x - constraint;
                
            }
            break;
            
        case DDQLayoutInstallBottom:
            
            self.verDirection = verDir != DDQLayoutOrigin ? : DDQLayoutBottomToTop;
            self.yStatus = yStatus != DDQLayoutStatusNone ? : DDQLayoutStatusY;
            
            if (yStatus == DDQLayoutStatusNone) {
                
                CGFloat y = [self getValueWithtProperty:property] + value;
                frame.origin.y = y;
                
            } else {
                
                CGFloat constraint = [self getValueWithtProperty:property] + value;
                frame.size.height = constraint > frame.origin.y ? constraint - frame.origin.y : frame.origin.y - constraint;
                
            }
            break;
            
        case DDQLayoutInstallCenterX:
            
            self.horDirection = horDir != DDQLayoutOrigin ? : DDQLayoutCenterX;
            self.xStatus = xStatus != DDQLayoutStatusNone ? : DDQLayoutStatusX;
            
            if (xStatus == DDQLayoutStatusNone) {
                
                CGFloat x = [self getValueWithtProperty:property] + value;
                frame.origin.x = x;
                
            } else {
                
                CGFloat constraint = [self getValueWithtProperty:property] + value;
                frame.size.width = constraint > frame.origin.x ? constraint - frame.origin.x : frame.origin.x - constraint;
                
            }
            break;

        case DDQLayoutInstallCenterY:
            
            self.verDirection = verDir != DDQLayoutOrigin ? : DDQLayoutCenterY;
            self.yStatus = yStatus != DDQLayoutStatusNone ? : DDQLayoutStatusY;
            
            if (yStatus == DDQLayoutStatusNone) {
                
                CGFloat y = [self getValueWithtProperty:property] + value;
                frame.origin.y = y;
                
            } else {
                
                CGFloat constraint = [self getValueWithtProperty:property] + value;
                frame.size.height = constraint > frame.origin.y ? constraint - frame.origin.y : frame.origin.y - constraint;
                
            }
            break;
            
        case DDQLayoutInstallCenter:
            
            self.horDirection = DDQLayoutCenter;
            self.verDirection = DDQLayoutCenter;
            self.xStatus = DDQLayoutStatusCenter;
            self.yStatus = DDQLayoutStatusCenter;
            
            CGFloat x = self.targetView.superview == property.view ? CGRectGetMidX(property.view.bounds) : CGRectGetMidX(property.view.frame);
            CGFloat y = self.targetView.superview == property.view ? CGRectGetMidY(property.view.bounds) : CGRectGetMidY(property.view.frame);
            frame.origin = CGPointMake(x + offset.xOffset, y + offset.yOffset);

            break;

        default:
            break;
            
    }
    self.targetView.frame = frame;
    
}

- (CGFloat)getValueWithtProperty:(DDQAutoLayoutProperty *)property {
    
    CGFloat value = 0.0;
    switch (property.property) {
            
        case DDQLayoutPropertyTop:
            value = (property.view == self.targetView.superview || !property) ? 0.0 : CGRectGetMinY(property.view.frame);
            break;
            
        case DDQLayoutPropertyLeft:
            value = (property.view == self.targetView.superview || !property) ? 0.0 : CGRectGetMinX(property.view.frame);
            break;
            
        case DDQLayoutPropertyBottom:
            value = (property.view == self.targetView.superview || !property) ? CGRectGetMaxY(property.view.bounds) : CGRectGetMaxY(property.view.frame);
            break;
            
        case DDQLayoutPropertyRight:
            value = (property.view == self.targetView.superview || !property) ? CGRectGetMaxX(property.view.bounds) :  CGRectGetMaxX(property.view.frame);
            break;
            
        case DDQLayoutPropertyCenterX:
            value = (property.view == self.targetView.superview || !property) ? CGRectGetMidX(property.view.bounds) :  CGRectGetMidX(property.view.frame);
            break;
            
        case DDQLayoutPropertyCenterY:
            value = (property.view == self.targetView.superview || !property) ? CGRectGetMidY(property.view.bounds) :  CGRectGetMidY(property.view.frame);
            break;
            
        default:
            break;
    }
    return value;
    
}

- (void)handleFinalFrameWithSize:(CGSize)size {
    
    CGFloat newX = CGRectGetMinX(self.targetView.frame);
    CGFloat newY = CGRectGetMinY(self.targetView.frame);
    switch (self.horDirection) {
            
        case DDQLayoutRightToLeft:
            newX -= size.width;
            break;

        case DDQLayoutCenterX:
            newX -= size.width * 0.5;
            break;
            
        case DDQLayoutCenter:
            newX -= size.width * 0.5;
            break;

        default:
            break;
    }
    
    switch (self.verDirection) {
            
        case DDQLayoutBottomToTop:
            newY -= size.height;
            break;

        case DDQLayoutCenterY:
            newY -= size.height * 0.5;
            break;

        case DDQLayoutCenter:
            newY -= size.height * 0.5;
            break;

        default:
            break;
    }
    CGRect frame = self.targetView.frame;
    frame.origin = CGPointMake(newX, newY);
    frame.size = size;
    self.targetView.frame = frame;
    
}

@end
