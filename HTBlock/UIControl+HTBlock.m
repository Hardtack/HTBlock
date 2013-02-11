//
//  UIControl+HTBlock.m
//  HTBlock
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 최건우. All rights reserved.
//

#import "UIControl+HTBlock.h"
#import <objc/runtime.h>

#define kUIControlEventsBinaryLength (sizeof(UIControlEvents) * 8)

@interface HTAction : NSObject

@property (nonatomic, strong) ActionBlock block;
// Single control event
@property (nonatomic) UIControlEvents controlEvent;

- (void)performAction:(id)sender;
- (id)initWithBlock:(ActionBlock)block controlEvents:(UIControlEvents)controlEvent;
+ (HTAction*)actionWithBlock:(ActionBlock)block controlEvents:(UIControlEvents)controlEvent;

@end

@implementation HTAction

- (void)performAction:(id)sender{
    if (self.block) {
        self.block(sender);
    }
}
- (id)initWithBlock:(ActionBlock)block controlEvents:(UIControlEvents)controlEvent{
    self = [super init];
    if (self) {
        self.block = block;
        self.controlEvent = controlEvent;
    }
    return self;
}

+ (HTAction *)actionWithBlock:(ActionBlock)block controlEvents:(UIControlEvents)controlEvent{
    return [[[self class] alloc] initWithBlock:block controlEvents:controlEvent];
}

- (BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[HTAction class]]) {
        HTAction *action = object;
        return (self.block == action.block) && (self.controlEvent == action.controlEvent);
    }
    return [super isEqual:object];
}

@end

@interface UIControl ()

@property (nonatomic, retain) NSMutableArray* actions;

@end

@implementation UIControl (HTBlock)

- (void)addTargetBlock:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents{
    NSMutableArray* actions = self.actions;
    for (NSUInteger i = 0; i < kUIControlEventsBinaryLength; i++) {
        UIControlEvents event = 1 << i;
        if ((controlEvents & event) == event) {
            HTAction *action = [HTAction actionWithBlock:block controlEvents:event];
            [self addTarget:action action:@selector(performAction:) forControlEvents:event];
            [actions addObject:action];
        }
    }
}

- (void)removeTargetBlock:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents{
    NSMutableArray* actions = self.actions;
    for (NSUInteger i = 0; i < kUIControlEventsBinaryLength; i++) {
        UIControlEvents event = 1 << i;
        if ((controlEvents & event) == event) {
            HTAction *action = [HTAction actionWithBlock:block controlEvents:event];
            if ([actions containsObject:action]) {
                [self removeTarget:action action:@selector(performAction:) forControlEvents:event];
                [actions removeObject:action];
            }
        }
    }
}

- (void)setActions:(NSMutableArray *)actions{
    objc_setAssociatedObject(self, "_actions", actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)actions{
    NSMutableArray* actions = objc_getAssociatedObject(self, "_actions");
    if (actions == nil) {
        actions = [NSMutableArray array];
        self.actions = actions;
    }
    return actions;
}

@end
