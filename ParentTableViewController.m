//
//  ParentTableViewController.m
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ParentTableViewController.h"
#import "Reachability.h"

@interface ParentTableViewController ()

@end

@implementation ParentTableViewController

//we need this to retrieve managed object context and later save data (for both Controllers)
//CRUCIAL TO remember to set this delegate below!!! 
- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Mobile device makers";
    self.dao = [[DAO alloc]init];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"notFirstLaunch"] == false)
    {
        //do stuff on first launch.
        NSLog(@"this is first time you are running the app");
        //The first time you run the app, Save Context in Core Data right after data gets initialized
//        [self.dao saveChanges];

        //after doing stuff on first launch, you set this key so that consequent times, this block never gets run
        [userDefaults setBool:YES forKey:@"notFirstLaunch"];
        [userDefaults synchronize];
    } else {
        //if it's not the first time you are running the app, you fetch from Core Data and sent your stuff equal to it;
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                          entityForName:@"Company" inManagedObjectContext:context];
           [fetchRequest setEntity:entity];
        NSError *error;
        NSArray *fetchedCompanies = [context executeFetchRequest:fetchRequest error:&error];
        NSLog(@"not the first time you are running the app");
    }
    
    
    //For Reachability check
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    [reach startNotifier];
    
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    //viewWillAppear is 1) first time you see view or 2) when you leave the page and come back to it later
    
    //making URL Request;
    NSURL *everything_url = [NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?s=%40%5EDJI,AAPL,SSNLF,htcxf,MSI&f=sl1&e=.csv"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:everything_url];
    //specify that it is a GET request
    request.HTTPMethod = @"GET";
    
    //create url connection and fire the request you made before
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest: request delegate: self];
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ChildTableViewController *childVC = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"childViewSegue"]) {
        childVC.title = [self.selectedCompany valueForKey:@"name"];
        childVC.selectedCompany = self.selectedCompany;
        childVC.products = self.dao.products;
        childVC.dao = self.dao;
        
        NSMutableArray* productsArrayForAppropriateCompany = [[NSMutableArray alloc]init];
        
        for (int i=0; i < childVC.products.count; i++) {
            Product* selectedProduct = childVC.products[i];
            if ([selectedProduct.company isEqualToString:childVC.selectedCompany.name]) {
                [productsArrayForAppropriateCompany addObject:selectedProduct];
            }
        }
        
        childVC.productsArrayForAppropriateCompany = productsArrayForAppropriateCompany;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dao.companies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    if (!self.dao.companies.count == 0) {
        Company * selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", selectedCompany.name, selectedCompany.stockPrice];
        [[cell imageView] setImage: [UIImage imageNamed: selectedCompany.image]];
        
        if ([self connected]) {
            cell.textLabel.backgroundColor = [UIColor whiteColor];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ (stock price outdated due to loss of internet connection)", selectedCompany.name, selectedCompany.stockPrice];
            cell.textLabel.backgroundColor = [UIColor redColor];
        }
    }

    return cell;
}

//IMPORTANT - this is the DELEGATE happens when you press on the row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"childViewSegue" sender:self];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


#pragma mark Reachability methods
- (BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    if([reach isReachable]) {
       NSLog(@"Internet is Reachable");
       }
    else {
       NSLog(@"Internet Connection UNReachable");
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Network Connection Alert" message:@"Network Connection Off or Unreachable" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
       [alert show];
    }
}

#pragma mark NSURLConnection Delegate Methods
//pragma marks make it easy to use Xcode jump bar to jump to different sections of your code, just a way of labeling your code so you can find it easier later

- (void) connection:(NSURLConnection* )connection didReceiveResponse:(NSURLResponse *)response {
    //this handler, gets hit ONCE
    //response has been received, we initialize the instance var we created in h file
    //then we append data to it in the didReceiveData method
    //    responseData = [[NSMutableData alloc] init];
}

- (void)connection: (NSURLConnection *)connection didReceiveData:(NSData *) data {
    //this handler, gets hit SEVERAL TIMES
    //Append new data to the instance variable everytime new data comes in
    
    if (!self.dao.companies.count == 0 )
        //company array null check - if it's null, then we don't make stupid requests which crash program
    {
        NSString *stockData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray *stockPairs = [stockData componentsSeparatedByString:@"\n"];
        
        for (int i=0; i < stockPairs.count-1; i++) {
            NSString *line = stockPairs[i];
            NSArray *pair = [line componentsSeparatedByString:@","];
            Company *selectedCompany = self.dao.companies[i];
            [selectedCompany setValue: @([pair[1] floatValue]) forKey:@"stockPrice"];
        }
        
        [self.tableView reloadData];
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    //Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //this handler, gets hit ONCE
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now or do whatever you want
    
    
    
    //    //if you just log out responseData here,
    //    NSString *strData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@", strData);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
