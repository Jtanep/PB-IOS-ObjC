//
//  ViewdefaultController.m
//  Paramount Bed IOS Obj-C
//
//  Created by Zerother on 4/16/2559 BE.
//  Copyright © 2559 Zerother. All rights reserved.
//

#import "ViewdefaultController.h"

@interface ViewdefaultController ()

@end

@implementation ViewdefaultController

@synthesize receivedData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        //Custom Initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    //sMemberID=1
    NSMutableString *post = [NSString stringWithFormat:@"sMemberID=%@",[self.sMemberID description]];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *url = [NSURL URLWithString:@"http://pb.zerother.com/getMemberId.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (theConnection) {
        self.receivedData = nil;
    } else {
        UIAlertView *connectFailMessage = [[UIAlertView alloc]
                                           initWithTitle:@"NSURLConnection" message:@"Fail in viewDidLoad" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [connectFailMessage show];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //[connection release];
    //[receivedData release];
    
    //inform the user
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle:@"NSURLConnection " message:@"didFailWithError" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [didFailWithErrorMessage show];
    //[didFailWithErrorMessage release];
    
    //inform the user
    NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (receivedData) {
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        //value in key name
        NSString *strMemberID = [jsonObjects objectForKey:@"MemberID"];
        NSLog(@"MemberID = %@",strMemberID);
        
    }
    
    //release the connection, and the data object
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //[super dealloc];
}

@end
