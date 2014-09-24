//
//  Company.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/24/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stockPrice;
@property (nonatomic, retain) NSString * stockSymbol;
@property (nonatomic, retain) NSSet *product_relationship;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addProduct_relationshipObject:(Product *)value;
- (void)removeProduct_relationshipObject:(Product *)value;
- (void)addProduct_relationship:(NSSet *)values;
- (void)removeProduct_relationship:(NSSet *)values;

@end
