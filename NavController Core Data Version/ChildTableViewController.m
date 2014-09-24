//
//  ChildTableViewController.m
//  NavController Core Data Version
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ChildTableViewController.h"
#import "ThirdViewController.h"

@interface ChildTableViewController ()

@end

@implementation ChildTableViewController

//we need this to retrieve managed object context and later save data (for both Controllers)
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
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ThirdViewController *thirdVC = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"thirdViewSegue"]) {
        
        thirdVC.selectedProduct = self.selectedProduct;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegates

//This method just puts a little title at left-top of the tableview, weird useless
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"TEST";
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    self.productsArrayForAppropriateCompany = [[NSMutableArray alloc]init];
    
    for (int i=0; i < self.products.count; i++) {
        Product* selectedProduct = self.products[i];
        if ([selectedProduct.company isEqualToString:self.selectedCompany.name]) {
            [self.productsArrayForAppropriateCompany addObject:selectedProduct];
        }
    }
    
    return self.productsArrayForAppropriateCompany.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    if (self.productsArrayForAppropriateCompany.count != 0) {
        Product *selectedProduct = [self.productsArrayForAppropriateCompany objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", selectedProduct.name];
        [[cell imageView] setImage: [UIImage imageNamed: selectedProduct.image]];
    }

    return cell;
}

//IMPORTANT - this is the DELEGATE happens when you SELECT/PRESS on the row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedProduct = [self.productsArrayForAppropriateCompany objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"thirdViewSegue" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


//DELETE DELEGATE
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source and then from the TableView
//        NSArray *productsArray = [self.selectedCompany.product_relationship allObjects];
//        NSNumber *indexNum = [NSNumber numberWithInteger:indexPath.row];
//        
//        for (int i=0; i < productsArray.count; i++) {
//            Product* selectedProduct = productsArray[i];
//            if ([selectedProduct.order_id isEqualToNumber:indexNum]) {
//                [self.selectedCompany removeProduct_relationshipObject:selectedProduct];
//            }
//        }
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}


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

@end
