//
//  ThirdViewController.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/24/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ThirdViewController : UIViewController


@property (strong, nonatomic) Product* selectedProduct;

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end
