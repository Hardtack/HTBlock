//
//  UIControl+HTBlock.h
//  HTBlock
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 최건우. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ActionBlock)(id sender);
@interface UIControl (HTBlock)

- (void)addTargetBlock:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents;
- (void)removeTargetBlock:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end
