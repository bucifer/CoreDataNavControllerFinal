//
//  ChildTableViewController.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface ChildTableViewController : UITableViewController <UITableViewDataSource>

@property (nonatomic) Company *selectedCompany;
@property (nonatomic) Product *selectedProduct;

@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSMutableArray *productsArrayForAppropriateCompany;

@property (nonatomic) DAO *dao;

@end
