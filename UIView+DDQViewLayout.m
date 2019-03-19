//
//  UIView+DDQViewLayout.m
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/3/19.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQViewLayout.h"

@implementation UIView (DDQViewLayout)

- (DDQAutoLayoutProperty *)ddqTop {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyTop view:self];
    
}

- (DDQAutoLayoutProperty *)ddqBottom {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyBottom view:self];
    
}

- (DDQAutoLayoutProperty *)ddqLeft {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyLeading view:self];
    
}

- (DDQAutoLayoutProperty *)ddqRight {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyTrailing view:self];
    
}

- (DDQAutoLayoutProperty *)ddqCenterX {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyCenterX view:self];
    
}

- (DDQAutoLayoutProperty *)ddqCenterY {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyCenterY view:self];
    
}

- (DDQAutoLayoutProperty *)ddqCenter {
    
    return [[DDQAutoLayoutProperty alloc] initWithProperty:DDQLayoutPropertyCenter view:self];
    
}

@end
