//
//  UIView+DDQViewLayoutMaker.h
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/7/11.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQViewLayoutInstall.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQMakerInstall)(DDQViewLayoutInstall *install);
typedef void(^DDQLayoutMaker)(DDQMakerInstall make);

@interface UIView (DDQViewLayoutMaker)

/**
 点语法
 */
@property (nonatomic, readonly) DDQLayoutMaker make;

/**
 对象方法
 */
- (void)make:(DDQMakerInstall)make;

@end

NS_ASSUME_NONNULL_END
