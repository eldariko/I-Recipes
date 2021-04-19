//
//  SignUpViewController.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "SignUpViewController.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameText.delegate=self;
    self.emailText.delegate=self;
    self.passwordText.delegate=self;
    self.reEnterPasswordText.delegate=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//sign up
- (IBAction)signUp:(id)sender {
    if([self.emailText.text isEqualToString:@""]|[self.userNameText.text isEqualToString:@""]||[self.passwordText.text isEqualToString:@""]||[self.reEnterPasswordText.text isEqualToString:@""])
    {
        [self showAlertWithInfo:@"Error!" info:@"You must complite all the fields"];
    }
    else{
        if([self checkPasswords]){
            if([CheckInternet checkInternet:self]){
            [[Model instance] signup:self.emailText.text userName:self.userNameText.text pwd:self.passwordText.text block:^(NSError* error) {
                if (!error) {
                    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"tabBar"]  animated:YES completion:nil];
                }
                else{
                    [self showAlertWithInfo:@"Error!" info:[error userInfo][@"error"]];
                }
                
            }];
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}

-(BOOL)checkPasswords{
    if([self.passwordText.text isEqualToString:self.reEnterPasswordText.text])
    {
        NSLog(@"PASSWORD MATCH!");
        return true;
    }
    else
    {
        NSLog(@"PASSWORD NOT MATCH");
        [self showAlertWithInfo:@"Error!" info:@"Your entered passwords do not match"];
        return false;
    }
}
-(void)showAlertWithInfo:(NSString*)title info:(NSString*)info{
    UIAlertController *e=[UIAlertController alertControllerWithTitle:title message:info preferredStyle:UIAlertControllerStyleAlert];
    [e addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * a){
        [e dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:e animated:YES completion:nil];
}

@end
