//
//  UIImagePickerController+HTBlock.h
//  meety_ios
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (HTBlock)

@property (nonatomic, strong) void(^finishBlock)(UIImagePickerController* picker, NSDictionary* info);
@property (nonatomic, strong) void(^cancelBlock)(UIImagePickerController* picker);

@end
