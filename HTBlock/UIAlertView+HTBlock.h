//
//  UIAlertView+HTBlock.h
//  meety_ios
//
//  Created by 최건우 on 13. 2. 11..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (HTBlock)

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles dismissBlock:(void(^)(UIAlertView* alertView, NSUInteger buttonIndex))dismissBlock;

@end
