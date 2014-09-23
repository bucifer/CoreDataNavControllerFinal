//
//  ParentTableViewController.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"


@interface ParentTableViewController : UITableViewController


@property (strong) DAO *dao;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
