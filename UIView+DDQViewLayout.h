//
//  UIView+DDQViewLayout.h
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/3/19.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQAutoLayoutProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DDQViewLayout)

@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqLeft;
@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqRight;
@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqTop;
@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqBottom;
@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqCenterX;
@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqCenterY;
@property (nonatomic, readonly) DDQAutoLayoutProperty *ddqCenter;

@end

NS_ASSUME_NONNULL_END
