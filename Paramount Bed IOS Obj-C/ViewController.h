//
//  ViewController.h
//  Paramount Bed IOS Obj-C
//
//  Created by Zerother on 3/28/2559 BE.
//  Copyright © 2559 Zerother. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPass;
    IBOutlet UIImageView *imglogo;
    IBOutlet UILabel *lbltest;
}

- (IBAction)btnLogin:(id)sender;

@property(nonatomic,assign) NSMutableData *receivedData;

@end

