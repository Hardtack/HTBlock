//
//  UIActionSheet+HTBlock.h
//  meety_ios
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (HTBlock)

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles dismissBlock:(void(^)(UIActionSheet* actionSheet, NSUInteger buttonIndex))dismissBlock;

@end
