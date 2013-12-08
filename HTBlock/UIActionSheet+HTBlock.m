/*
 * UIActionSheet+HTBlock.m
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *                    Version 2, February 2013
 *
 * Copyright (C) 2013 GunWoo Choi
 *
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 *
 *  0. You just DO WHAT THE FUCK YOU WANT TO.
 *
 */

#import "UIActionSheet+HTBlock.h"
#import <objc/runtime.h>

@interface UIActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) void(^didDismissBlock)(UIActionSheet* actionSheet, NSUInteger buttonIndex);
@property (nonatomic, strong) void(^willDismissBlock)(UIActionSheet* actionSheet, NSUInteger buttonIndex);

@end

@implementation UIActionSheet (HTBlock)

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles dismissBlock:(void(^)(UIActionSheet* actionSheet, NSUInteger buttonIndex))dismissBlock {
    return [self initWithTitle:title
             cancelButtonTitle:cancelButtonTitle
        destructiveButtonTitle:destructiveButtonTitle
             otherButtonTitles:otherButtonTitles
              willDismissBlock:nil
               didDismissBlock:dismissBlock];
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles willDismissBlock:(void(^)(UIActionSheet* actionSheet, NSUInteger buttonIndex))willDismissBlock {
    return [self initWithTitle:title
             cancelButtonTitle:cancelButtonTitle
        destructiveButtonTitle:destructiveButtonTitle
             otherButtonTitles:otherButtonTitles
              willDismissBlock:willDismissBlock
               didDismissBlock:nil];
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles willDismissBlock:(void(^)(UIActionSheet* actionSheet, NSUInteger buttonIndex))willDismissBlock didDismissBlock:(void(^)(UIActionSheet* actionSheet, NSUInteger buttonIndex))didDismissBlock {
    self = [self initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    if (self) {
        for (NSString* otherTitle in otherButtonTitles) {
            [self addButtonWithTitle:otherTitle];
        }
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = self.numberOfButtons - 1;
        }
        self.willDismissBlock = willDismissBlock;
        self.didDismissBlock = didDismissBlock;
        self.delegate = self;
    }
    return self;
}

- (void (^)(UIActionSheet *, NSUInteger))willDismissBlock{
    return objc_getAssociatedObject(self, "_willDismissBlock");
}

- (void)setWillDismissBlock:(void (^)(UIActionSheet *, NSUInteger))willDismissBlock {
    objc_setAssociatedObject(self, "_willDismissBlock", willDismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIActionSheet *, NSUInteger))didDismissBlock{
    return objc_getAssociatedObject(self, "_didDismissBlock");
}

- (void)setDidDismissBlock:(void (^)(UIActionSheet *, NSUInteger))didDismissBlock {
    objc_setAssociatedObject(self, "_didDismissBlock", didDismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.willDismissBlock) {
        self.willDismissBlock(actionSheet, buttonIndex);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (self.didDismissBlock) {
        self.didDismissBlock(actionSheet, buttonIndex);
    }
}

@end
