//
//  UIImagePickerController+HTBlock.m
//  meety_ios
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import "UIImagePickerController+HTBlock.h"
#import <objc/runtime.h>

@interface UIImagePickerController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation UIImagePickerController (HTBlock)

- (void)setFinishBlock:(void (^)(UIImagePickerController *, NSDictionary *))finishBlock{
    if (finishBlock != nil) {
        self.delegate = self;
    } else if(self.cancelBlock == nil) {
        self.delegate = nil;
    }
    objc_setAssociatedObject(self, "_finishBlock", finishBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIImagePickerController *, NSDictionary *))finishBlock{
    return objc_getAssociatedObject(self, "_finishBlock");
}

- (void)setCancelBlock:(void (^)(UIImagePickerController *))cancelBlock{
    if (cancelBlock != nil) {
        self.delegate = self;
    } else if (self.finishBlock == nil) {
        self.delegate = nil;
    }
    objc_setAssociatedObject(self, "_cancelBlock", cancelBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIImagePickerController *))cancelBlock{
    return objc_getAssociatedObject(self, "_cancelBlock");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (self.finishBlock) {
        self.finishBlock(picker, info);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if (self.cancelBlock) {
        self.cancelBlock(picker);
    }
}

@end
