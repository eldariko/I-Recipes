//
//  NewRecipeViewController.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 28/12/15.
//  Copyright © 2015 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInternet.h"
@protocol NewRecipeDelegate<NSObject>
-(void)onSave:(NSString*)recipeName ingredients:(NSString*)ingredients directions:(NSString*)directions recipeImage:(UIImageView *)image categoryName:(NSString*)categoryName user:(NSString*)user;
@end

@interface NewRecipeViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate>{
    UIImagePickerController* imagePicker;
}
@property (weak, nonatomic) IBOutlet UITextField *recipeNameText;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsText;
@property (weak, nonatomic) IBOutlet UITextView *directionsText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property NSString* categoryName;

@property NSString* user;
- (IBAction)saveBtn:(id)sender;
- (IBAction)addPicture:(id)sender;
- (IBAction)clearBtn:(id)sender;
@property id<NewRecipeDelegate> delegate;
@end