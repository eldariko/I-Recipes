//
//  SignUpViewController.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "CheckInternet.h"


@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordText;
- (IBAction)signUp:(id)sender;
-(BOOL)checkPasswords;

@end
