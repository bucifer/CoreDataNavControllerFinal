//
//  ThirdViewController.m
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/24/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    
}

- (void)viewDidAppear:(BOOL)animated
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection so can't load webpage");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Network Connection Alert" message:@"Network connection is off so couldn't load the webpage" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    } else {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.selectedProduct.url] ] ];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
