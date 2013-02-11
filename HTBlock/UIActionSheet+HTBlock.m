//
//  UIActionSheet+HTBlock.m
//  meety_ios
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import "UIActionSheet+HTBlock.h"
#import <objc/runtime.h>

@interface UIActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) void(^dismissBlock)(UIActionSheet* actionSheet, NSUInteger buttonIndex);

@end

@implementation UIActionSheet (HTBlock)

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles dismissBlock:(void(^)(UIActionSheet* actionSheet, NSUInteger buttonIndex))dismissBlock{
    self = [self initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    if (self) {
        for (NSString* otherTitle in otherButtonTitles) {
            [self addButtonWithTitle:otherTitle];
        }
        self.dismissBlock = dismissBlock;
        self.delegate = self;
    }
    return self;
}

- (void (^)(UIActionSheet *, NSUInteger))dismissBlock{
    return objc_getAssociatedObject(self, "_dismissBlock");
}

- (void)setDismissBlock:(void (^)(UIActionSheet *, NSUInteger))dismissBlock{
    objc_setAssociatedObject(self, "_dismissBlock", dismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (self.dismissBlock) {
        self.dismissBlock(actionSheet, buttonIndex);
    }
}

@end
