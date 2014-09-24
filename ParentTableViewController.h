//
//  ParentTableViewController.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Reachability.h"
#import "ChildTableViewController.h"

@class ChildTableViewController;
@class Reachability;

@interface ParentTableViewController :UITableViewController {
    Reachability *internetReachableFoo;
}

@property (strong) DAO *dao;

@property (strong, nonatomic) IBOutlet UITableViewCell *parentViewCell;

@property Company *selectedCompany;

@property BOOL connectionLost;

- (BOOL)connected;
- (void)reachabilityDidChange:(NSNotification *)notification;

 


@end
