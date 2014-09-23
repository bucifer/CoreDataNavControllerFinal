//
//  Company.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
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
@property (nonatomic, retain) NSSet *product;


- (id)initWithName:(NSString *)aName Image:(NSString*)imageName symbol:(NSString*)aSymbol;


@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addProductObject:(Product *)value;
- (void)removeProductObject:(Product *)value;
- (void)addProduct:(NSSet *)values;
- (void)removeProduct:(NSSet *)values;

@end
