//
//  DAO.h
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface DAO : NSObject

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) NSMutableArray* companies;
@property (nonatomic, strong) NSMutableArray* products;
@property (nonatomic, strong) Company* selectedCompany;

- (id)init;

- (Company*) TBinitCompany: (NSString *)put_name image:(NSString*)put_image stockSymbol:(NSString *)put_symbol moc:(NSManagedObjectContext*) context;

@end
