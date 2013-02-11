//
//  UIAlertView+HTBlock.m
//  meety_ios
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import "UIAlertView+HTBlock.h"
#import <objc/runtime.h>

@interface UIAlertView () <UIAlertViewDelegate>

@property (nonatomic, strong) void(^dismissBlock)(UIAlertView*, NSUInteger);

@end

@implementation UIAlertView (HTBlock)
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles dismissBlock:(void(^)(UIAlertView* alertView, NSUInteger buttonIndex))dismissBlock{
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        // Set titles
        for (NSString *otherTitle in otherButtonTitles) {
            [self addButtonWithTitle:otherTitle];
        }
        self.dismissBlock = dismissBlock;
        self.delegate = self;
    }
    return self;
}

- (void) alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSUInteger)buttonIndex{
    if (self.dismissBlock) {
        self.dismissBlock(alertView, buttonIndex);
    }
}

- (void)setDismissBlock:(void (^)(UIAlertView *, NSUInteger))dismissBlock{
    objc_setAssociatedObject(self, "_dismissBlock", dismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIAlertView *, NSUInteger))dismissBlock{
    return objc_getAssociatedObject(self, "_dismissBlock");
}

@end
