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

- (Company*) TBinitCompany: (NSString *)put_name image:(NSString*)put_image stockSymbol:(NSString *)put_symbol moc:(NSManagedObjectContext*) context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:context];
    Company *company = [[Company alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    company.name = put_name;
    company.image = put_image;
    company.stockSymbol = put_symbol;
    
    return company;
}

- (Product*) TBinitProduct: (NSString *)put_name image:(NSString*)put_image url:(NSString *)put_url company:(NSString *)put_company moc:(NSManagedObjectContext*) context {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:context];
    Product *product = [[Product alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    product.name = put_name;
    product.image = put_image;
    product.url = put_url;
    product.company = put_company;
    
    return product;
}


- (id)init {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Company *apple = [self TBinitCompany:@"Apple" image:@"apple.png" stockSymbol:@"AAPL" moc:context];
    Company *samsung = [self TBinitCompany:@"Samsung" image:@"samsung.png" stockSymbol:@"SSNLF" moc:context];
    Company *htc = [self TBinitCompany:@"HTC" image:@"htc.jpg" stockSymbol:@"HTCXF" moc:context];
    Company *motorola = [self TBinitCompany:@"Motorola" image:@"motorola.gif" stockSymbol:@"MSI" moc:context];
    
    self.companies = [[NSMutableArray alloc] initWithObjects:
                      apple, samsung, htc, motorola, nil];
    
    Company *select = self.companies[0];
    NSLog(@"%@", select.name);
//
//    Company *apple1 = self.companies[0];
//    //Put product objects into the products array for the company
    
    Product *ipad = [self TBinitProduct:@"iPad" image:@"ipad.png" url:@"https://www.apple.com/ipad/" company:@"Apple" moc:context];
    Product *ipodTouch = [self TBinitProduct:@"iPod Touch" image:@"ipod_touch.png" url:@"http://www.apple.com/ipod-touch" company:@"Apple" moc:context];
    Product *iPhone = [self TBinitProduct:@"iPhone" image:@"iphone.png" url:@"http://www.apple.com/iphone" company:@"Apple" moc:context];

//    apple1.products = [[NSMutableArray alloc]
//                       initWithObjects:
//                       ipad, ipod_touch, iphone, nil];
//    
//    Company *samsung2 = self.companies[1];
//    //Put product objects into the products array for the company
//    Product *s4 = [[Product alloc]initWithName:@"Galaxy S4" Image:@"galaxy_s4.png" url:@"http://www.samsung.com/global/microsite/galaxys4/" Company:@"Samsung"];
//    Product *note = [[Product alloc]initWithName:@"Galaxy Note" Image:@"galaxy_note.jpg_256" url:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html" Company:@"Samsung"];
//    Product *tab = [[Product alloc]initWithName:@"Galaxy Tab" Image:@"galaxy_tab.jpg" url:@"http://www.samsung.com/us/mobile/galaxy-tab/" Company:@"Samsung"];
//    samsung2.products = [[NSMutableArray alloc]
//                         initWithObjects: s4, note, tab, nil];
//    
//    Company *htc3 = self.companies[2];
//    Product *m8 = [[Product alloc]initWithName:@"HTC One M8" Image:@"htc_m8.jpg" url:@"http://www.htc.com/us/smartphones/htc-one-m8/" Company:@"HTC"];
//    Product *remix = [[Product alloc]initWithName:@"HTC One Remix" Image:@"htc_one_remix.png" url:@"http://www.htc.com/us/smartphones/htc-one-remix/" Company:@"HTC"];
//    Product *flyer = [[Product alloc]initWithName:@"HTC Flyer" Image:@"htc_flyer.png" url:@"http://www.amazon.com/HTC-Flyer-Android-Tablet-16/dp/B0053RJ3F8" Company:@"HTC"];
//    htc3.products = [[NSMutableArray alloc]
//                     initWithObjects: m8, remix, flyer, nil];
//    
//    
//    Company *motorola4 = self.companies[3];
//    Product *moto_x = [[Product alloc]initWithName:@"Moto X" Image:@"moto_x.png" url:@"https://www.motorola.com/us/motomaker?pid=FLEXR2" Company:@"Motorola"];
//    Product *moto_g = [[Product alloc]initWithName:@"Moto G" Image:@"moto_g.jpg" url:@"http://www.motorola.com/us/moto-g-pdp-1/Moto-G-(1st-Gen.)/moto-g-pdp.html" Company:@"Motorola"];
//    Product *moto_360 = [[Product alloc]initWithName:@"Moto 360" Image:@"moto_360.png" url:@"http://www.androidcentral.com/moto-360" Company:@"Motorola"];
//    motorola4.products = [[NSMutableArray alloc]
//                          initWithObjects: moto_x, moto_g, moto_360, nil];
//    for (int i=0; i < motorola4.products.count; i++) {
//        Product *selectedProduct = motorola4.products[i];
//        selectedProduct.company = motorola.name;
//    }
    
    return self;
}





@end
