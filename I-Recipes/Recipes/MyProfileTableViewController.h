//
//  MyProfileTableViewController.h
//  Recipes
//
//  Created by Admin on 1/4/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "CheckInternet.h"
#import "Model.h"
@interface MyProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *email;
- (IBAction)logOutBtn:(id)sender;

@end
