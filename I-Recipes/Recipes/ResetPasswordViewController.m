//
//  ResetPasswordViewController.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}

- (IBAction)onReset:(UIButton *)sender {
    if (self.emailTxt.text.length ==0 ) {
        [self.emailTxt becomeFirstResponder];
    }
    else if([CheckInternet checkInternet:self]){
        [[Model instance] resetPassword:_emailTxt.text block:^(bool result) {
        if (result) {
            [self showAlertWithInfo:@"reset password request" info:@"We've sent a reset password link to these email addrese"];
        }else [self showAlertWithInfo:@"reset problem" info:@"no account was found for the email address."];
    }];
    }
}

-(void)showAlertWithInfo:(NSString*)title info:(NSString*)info{
    UIAlertController *e=[UIAlertController alertControllerWithTitle:title message:info preferredStyle:UIAlertControllerStyleAlert];
    [e addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * a){
        [e dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:e animated:YES completion:nil];
}
@end
