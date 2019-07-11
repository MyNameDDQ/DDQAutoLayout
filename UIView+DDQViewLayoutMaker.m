//
//  UIView+DDQViewLayoutMaker.m
//  DDQAutoLayout
//
//  Created by 我叫咚咚枪 on 2019/7/11.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQViewLayoutMaker.h"

@implementation UIView (DDQViewLayoutMaker)

- (DDQLayoutMaker)make {
    
    return ^ void (DDQMakerInstall make) {
      
        [self view_initializeWithMake:make];

    };
}

- (void)make:(DDQMakerInstall)make {
    
    [self view_initializeWithMake:make];
    
}

- (void)view_initializeWithMake:(DDQMakerInstall)make {
    
    DDQViewLayoutInstall *install = [[DDQViewLayoutInstall alloc] initWithView:self];
    make(install);
    [install uninstall];

}

@end
