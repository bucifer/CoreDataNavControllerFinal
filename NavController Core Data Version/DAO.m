//
//  DAO.m
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "DAO.h"
#import "Company.h"
#import "Product.h"

@implementation DAO

@synthesize managedObjectContext;

//we need this to retrieve managed object context and later save data (for both Controllers)
- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}



- (id)initFirstTime {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Company *apple = [self TBinitCompany:@"Apple" image:@"apple.png" stockSymbol:@"AAPL" moc:context];
    Company *samsung = [self TBinitCompany:@"Samsung" image:@"samsung.png" stockSymbol:@"SSNLF" moc:context];
    Company *htc = [self TBinitCompany:@"HTC" image:@"htc.jpg" stockSymbol:@"HTCXF" moc:context];
    Company *motorola = [self TBinitCompany:@"Motorola" image:@"motorola.gif" stockSymbol:@"MSI" moc:context];
    
    self.companies = [[NSMutableArray alloc] initWithObjects:
                      apple, samsung, htc, motorola, nil];
    
    Product *ipad = [self TBinitProduct:@"iPad" image:@"ipad.png" url:@"https://www.apple.com/ipad/" company:@"Apple" moc:context orderID:@0];
    Product *ipodTouch = [self TBinitProduct:@"iPod Touch" image:@"ipod_touch.png" url:@"http://www.apple.com/ipod-touch" company:@"Apple" moc:context orderID:@1];
    Product *iphone = [self TBinitProduct:@"iPhone" image:@"iphone.png" url:@"http://www.apple.com/iphone" company:@"Apple" moc:context orderID:@2];
    
    Product *s4 = [self TBinitProduct:@"Galaxy S4" image:@"galaxy_s4.png" url:@"http://www.samsung.com/global/microsite/galaxys4/" company:@"Samsung" moc:context orderID:@0];
    Product *note = [self TBinitProduct:@"Galaxy Note" image:@"galaxy_note.jpg_256" url:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find" company:@"Samsung" moc:context orderID:@1];
    Product *tab = [self TBinitProduct:@"Galaxy Tab" image:@"galaxy_tab.jpg" url:@"http://www.samsung.com/us/mobile/galaxy-tab/" company:@"Samsung" moc:context orderID:@2];

    Product *m8 = [self TBinitProduct:@"HTC One M8" image:@"htc_m8.jpg" url:@"http://www.htc.com/us/smartphones/htc-one-m8/" company:@"HTC" moc:context orderID:@0];
    Product *remix = [self TBinitProduct:@"HTC One Remix" image:@"htc_one_remix.png" url:@"http://www.htc.com/us/smartphones/htc-one-remix/" company:@"HTC" moc:context orderID:@1];
    Product *flyer = [self TBinitProduct:@"HTC Flyer" image:@"htc_flyer.png" url:@"http://www.amazon.com/HTC-Flyer-Android-Tablet-16/dp/B0053RJ3F8" company:@"HTC" moc:context orderID:@2];


    Product *moto_x = [self TBinitProduct:@"Moto X" image:@"moto_x.png" url:@"https://www.motorola.com/us/motomaker?pid=FLEXR2" company:@"Motorola" moc:context orderID:@0];
    Product *moto_g = [self TBinitProduct:@"Moto G" image:@"moto_g.jpg" url:@"http://www.motorola.com/us/moto-g-pdp-1/Moto-G-(1st-Gen.)/moto-g-pdp.html" company:@"Motorola" moc:context orderID:@1];
    Product *moto_360 = [self TBinitProduct:@"Moto 360" image:@"moto_360.png" url:@"http://www.androidcentral.com/moto-360" company:@"Motorola" moc:context orderID:@2];
    
    self.products = [[NSMutableArray alloc] initWithObjects:
                     ipad, ipodTouch, iphone, s4, note, tab, m8, remix, flyer, moto_x, moto_g, moto_360, nil];

    [self saveChanges];
    
    
    return self;
}

- (Company*) TBinitCompany: (NSString *)put_name image:(NSString*)put_image stockSymbol:(NSString *)put_symbol moc:(NSManagedObjectContext*) context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:context];
    Company *company = [[Company alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    //if the insertIntoManagedObjectContext argument is nil, means this is just a pointer and not getting saved into context
    //http://stackoverflow.com/questions/8139033/use-nsmanagedobject-class-without-initwithentity for more info
    
    company.name = put_name;
    company.image = put_image;
    company.stockSymbol = put_symbol;
    
    return company;
}

- (Product*) TBinitProduct: (NSString *)put_name image:(NSString*)put_image url:(NSString *)put_url company:(NSString *)put_company moc:(NSManagedObjectContext*) context orderID:(NSNumber *)put_order_id{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:context];
    Product *product = [[Product alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    
    product.name = put_name;
    product.image = put_image;
    product.url = put_url;
    product.company = put_company;
    product.order_id = put_order_id;
    
    return product;
}



- (NSMutableArray *) requestCDAndFetch: (NSString *) entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedProducts = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    return [fetchedProducts mutableCopy];
}


- (void) deleteProduct: (Product*) product {
    NSLog(@"deleteProduct method called from childviewcontroller");
    
    //We delete from the DAO memory
    [self.products removeObject:product];
    
    //Then we delete from our Core Data
    [self.managedObjectContext deleteObject:product];
    
    [self saveChanges];
    NSLog(@"Product %@ Delete successful", product.name);
}


-(void) saveChanges
{
    NSError *err = nil;
    BOOL successful = [self.managedObjectContext save:&err];
    if(!successful){
        NSLog(@"Error saving: %@", [err localizedDescription]);
    } else {
        NSLog(@"Data Saved");
    }
}



@end
