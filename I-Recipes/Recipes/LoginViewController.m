//
//  ViewController.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameText.delegate=self;
    self.passwordText.delegate=self;
        // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//login
- (IBAction)loginBtn:(id)sender {
    if([self.userNameText.text isEqualToString:@""]||[self.passwordText.text isEqualToString:@""])
    {
        [self showAlertWithInfo:@"Error!" info:@"You must complite all the fields"];
    }
    else{
         if([CheckInternet checkInternet:self])
         {
        [[Model instance] login:self.userNameText.text pwd:self.passwordText.text block:^(NSError* error) {
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

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}

-(void)showAlertWithInfo:(NSString*)title info:(NSString*)info{
    UIAlertController *e=[UIAlertController alertControllerWithTitle:title message:info preferredStyle:UIAlertControllerStyleAlert];
    [e addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * a){
        [e dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:e animated:YES completion:nil];
}
-(IBAction)unwindToLoginController:(UIStoryboardSegue *)unwindSegue{};
@end
