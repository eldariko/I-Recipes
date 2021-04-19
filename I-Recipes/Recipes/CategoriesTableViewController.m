//
//  CategoriesTableViewController.m
//  Recipes
//
//  Created by Lital Zigron on 30/12/15.
//  Copyright © 2015 Lital Zigron. All rights reserved.
//

#import "CategoriesTableViewController.h"

@interface CategoriesTableViewController ()

@end

@implementation CategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array=[[NSArray alloc]initWithObjects:@"Soups", @"Salads",@"Italian",@"Side Dishes",@"Desserts", @"Healty Food", @"Other", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    cell.categoryName.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toRecipeCategory"])
    {
        RecipesTableViewController* rtvc =segue.destinationViewController;
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        rtvc.category=[self.array objectAtIndex:indexPath.row];
    }
}
@end
