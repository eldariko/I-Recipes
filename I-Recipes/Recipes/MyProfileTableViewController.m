//
//  MyProfileTableViewController.m
//  Recipes
//
//  Created by Admin on 1/4/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//
#import "LoginViewController.h"
#import "MyProfileTableViewController.h"
@interface MyProfileTableViewController ()

@end

@implementation MyProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([CheckInternet checkInternet:self])
    {
    [[Model instance]getUserNameAndMail:^(NSString *name, NSString *mail) {
        _userName.text=name;
        _email.text=mail;
    }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(IBAction)unwindToMyProfile:(UIStoryboardSegue *)unwindSegue{};


- (IBAction)logOutBtn:(id)sender {
    if([CheckInternet checkInternet:self])
    {
        [[Model instance]logOut:^(void){}];
        
        if ([self.view.window.rootViewController isKindOfClass:[LoginViewController class]]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            //[self performSegueWithIdentifier:@"toLogin" sender:self];
           // NSLog(@"%@", self.view.window.rootViewController);
            
            LoginViewController* loVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
            self.view.window.rootViewController=loVC;
            //[self dismissViewControllerAnimated:YES completion:nil];
            }
    }
}
@end
