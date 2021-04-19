//
//  ViewController.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "SignUpViewController.h"
#import "Model.h"
#import "CheckInternet.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)loginBtn:(id)sender;

@end

