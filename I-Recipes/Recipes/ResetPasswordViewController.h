//
//  ResetPasswordViewController.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "LoginViewController.h"

@interface ResetPasswordViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
- (IBAction)onReset:(UIButton *)sender;

@end
