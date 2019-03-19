//
//  DDQAutoLayoutProperty.h
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/3/19.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQLayoutProperty) {
    
    DDQLayoutPropertyLeft = 1,      //左
    DDQLayoutPropertyRight,         //右
    DDQLayoutPropertyTop,           //顶
    DDQLayoutPropertyBottom,        //底
    DDQLayoutPropertyCenterX,       //X对齐
    DDQLayoutPropertyCenterY,       //Y对齐
    DDQLayoutPropertyCenter,        //中心对齐
    DDQLayoutPropertyLeading = DDQLayoutPropertyLeft,
    DDQLayoutPropertyTrailing = DDQLayoutPropertyRight,
    
};

@interface DDQAutoLayoutProperty : NSObject

/**
 初始化方法
 
 @param property 选择布局方式
 @param view 待布局的视图
 */
- (instancetype)initWithProperty:(DDQLayoutProperty)property view:(nullable __kindof UIView *)view NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly, assign) DDQLayoutProperty property;
@property (nonatomic, readonly, strong, nullable) UIView *view;

@end

NS_ASSUME_NONNULL_END
