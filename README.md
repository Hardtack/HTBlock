HTBlock
=======

Some block additions for UIKit.  

How To Use It
-------------

Just copy/link sources to your project, and use it! It's so easy to use.  

Example
-------

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
