//
//  DAO.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) NSMutableArray* companies;
@property (nonatomic, strong) NSMutableArray* products;
@property (nonatomic, strong) Company* selectedCompany;

- (id)initFirstTime;

- (Company*) TBinitCompany: (NSString *)put_name image:(NSString*)put_image stockSymbol:(NSString *)put_symbol moc:(NSManagedObjectContext*) context;

- (Product*) TBinitProduct: (NSString *)put_name image:(NSString*)put_image url:(NSString *)put_url company:(NSString *)put_company moc:(NSManagedObjectContext*) context orderID:(NSNumber*)put_order_id;

- (void) deleteProduct: (Product*) product;

-(void) saveChanges;

- (NSMutableArray *) requestCDAndFetch: (NSString *) entityName;


@end
