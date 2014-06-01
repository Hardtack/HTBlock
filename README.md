HTBlock
=======

Some block additions for UIKit.  

How To Use It
-------------

Just copy/link sources to your project, and use it! It's so easy to use.  

You can also install HTBlock with [CocoaPods](http://cocoapods.org/).  

    `pod 'HTBlock', '~> 0.1.0'`

Example
-------

*   `UIAlertView`

        [[[UIAlertView alloc] initWithTitle:@"Title"
                                    message:@"Message"
                          cancelButtonTitle:@"No"
                          otherButtonTitles:@[@"Yes"]
                               dismissBlock:^(UIAlertView *alertView, NSUInteger buttonIndex) {
                                if (buttonIndex == alertView.cancelButtonIndex) {
                                    return;
                                } else {
                                    NSLog(@"YES");
                                }
        }] show];

*   `UIControl`

        [button addTargetBlock:^(id sender) {
            NSLog(@"Button Pressed");
        } forControlEvents:UIControlEventTouchUpInside];

