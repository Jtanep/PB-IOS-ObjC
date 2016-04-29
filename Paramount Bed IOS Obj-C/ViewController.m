//
//  ViewController.m
//  Paramount Bed IOS Obj-C
//
//  Created by Zerother on 3/28/2559 BE.
//  Copyright © 2559 Zerother. All rights reserved.
//

#import "ViewController.h"
#import "ViewdefaultController.h"

@interface ViewController ()
{
    UIAlertView *loading;
}
@end

@implementation ViewController
@synthesize receivedData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)btnLogin:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    loading = [[UIAlertView alloc] initWithTitle:@""  message:@"Login Checking..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [loading show];
    
    //Check username&pass
    NSMutableString *post = [NSString stringWithFormat:@"sUsername=%@&sPassword=%@",[txtUsername text],[txtPass text]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSURL *url = [NSURL URLWithString:@"http://pb.zerother.com/checkLogin.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (theConnection) {
        self.receivedData= nil;
    } else {
        UIAlertView *connectFailMessage = [[UIAlertView alloc]
                                           initWithTitle:@"NSURLConnection" message:@"Failed in viewDidLoad" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [connectFailMessage show];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    sleep(3);
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //[connection release];
    //[receivedData release];
    
    //inform the user
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle:@"NSURLConnection " message:@"didFailWithError" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [didFailWithErrorMessage show];
    
    
    //inform the user
    NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Hide Progress
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
    //Return Status E.g :
    //0=Error;
    //1=Completed
    
    if (receivedData) {
        //NSLog(@"%@", receivedData);
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        //value in key name
        NSString *strStatus = [jsonObjects objectForKey:@"Status"];
        NSString *strMemberID = [jsonObjects objectForKey:@"MemberID"];
        NSString *strMessage = [jsonObjects objectForKey:@"Message"];
        NSLog(@"Status=%@",strStatus);
        NSLog(@"MemberID=%@",strMemberID);
        NSLog(@"Message=%@",strMessage);
        
        //Login Completed
        if([strStatus isEqualToString:@"1"]){
            
            ViewdefaultController *viewInfo = [[[ViewdefaultController alloc] initWithNibName:nil bundle:nil] autorelease];
            viewInfo.sMemberID = strMemberID;
            [self presentViewController:viewInfo animated:NO completion:NULL];
        }
        else{
            UIAlertView *error = [[UIAlertView alloc]
                                  initWithTitle:@":( Error!" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [error show];
        }
        
    }
    
    //release the connection, and the data object
    //[connection release];
    //[receivedData release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //[txtUsername release];
    //[txtPass release];
    //[super dealloc];
    
}

@end
