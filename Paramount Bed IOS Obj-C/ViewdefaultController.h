//
//  ViewdefaultController.h
//  Paramount Bed IOS Obj-C
//
//  Created by Zerother on 4/16/2559 BE.
//  Copyright © 2559 Zerother. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewdefaultController : UIViewController
{

    IBOutlet UIImageView *imgqrsearch;
    IBOutlet UIImageView *imgserial;
    IBOutlet UIImageView *add;
}

@property (strong, nonatomic) id sMemberID;
@property(nonatomic,assign) NSMutableData *receivedData;

@end
