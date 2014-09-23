//
//  Product.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * company_id;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) Company *company_relationship;

@end
