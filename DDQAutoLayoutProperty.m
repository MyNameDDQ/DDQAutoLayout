//
//  DDQAutoLayoutProperty.m
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/3/19.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQAutoLayoutProperty.h"

@interface DDQAutoLayoutProperty ()

@property (nonatomic, readwrite, assign) DDQLayoutProperty property;
@property (nonatomic, readwrite, strong) UIView *view;

@end

@implementation DDQAutoLayoutProperty

- (instancetype)initWithProperty:(DDQLayoutProperty)property view:(__kindof UIView *)view {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.property = property;
    self.view = view;
    
    return self;
    
}

@end
