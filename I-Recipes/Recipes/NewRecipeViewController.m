//
//  NewRecipeViewController.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 28/12/15.
//  Copyright © 2015 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "NewRecipeViewController.h"
#import "RecipesTableViewController.h"
#import "Model.h"
@interface NewRecipeViewController ()
{
    NSMutableArray* dataRecipe;
     NSArray *categoryPickerData;
}
@end

@implementation NewRecipeViewController

- (void)viewDidLoad {    
    self.activityIndicator.hidden = YES;
    self.recipeNameText.delegate=self;
    self.categoryPicker.dataSource=self;
    self.categoryPicker.delegate=self;
    [super viewDidLoad];
    if([CheckInternet checkInternet:self]){
    dataRecipe= [[NSMutableArray alloc]init];
    categoryPickerData=@[@"Soups", @"Salads",@"Italian",@"Side Dishes",@"Desserts", @"Healthy Food", @"Other"];
        [self.categoryPicker selectRow:0 inComponent:0 animated:YES];
        _categoryName=@"Soups";
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}

- (IBAction)clearBtn:(id)sender {
    self.recipeNameText.text=@"";
    self.ingredientsText.text=@"";
    self.directionsText.text=@"";
    self.imageView.image=nil ;
}
- (IBAction)saveBtn:(id)sender {
    if ([self checkData]) {
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        if([CheckInternet checkInternet:self])
        {
            self.user=[[Model instance] getCurrentUserId];
            Recipe* newRecipe=[[Recipe alloc] init:self.recipeNameText.text ingredients:self.ingredientsText.text directions:self.directionsText.text imageName:self.recipeNameText.text categoryName:self.categoryName user:self.user];
            [[Model instance] addRecipeAsynch:newRecipe block:^(BOOL flag){
                if(flag==YES){
                    [[Model instance] saveRecipeImage:newRecipe image:self.imageView.image block:^(NSError * error) {
                        int controllerIndex=1;
                        UITabBarController *tabBarController = self.tabBarController;
                        UIView * fromView = tabBarController.selectedViewController.view;
                        UIView * toView = [[tabBarController.viewControllers objectAtIndex:controllerIndex] view];
                        // Transition to recipes tab.
                        [UIView transitionFromView:fromView
                                            toView:toView
                                          duration:0.2
                                           options:(controllerIndex > tabBarController.selectedIndex ? UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptionTransitionCurlDown)
                                        completion:^(BOOL finished) {
                                            if (finished) {
                                                tabBarController.selectedIndex = controllerIndex;
                                                [self.activityIndicator stopAnimating];
                                                self.activityIndicator.hidden =YES;
                                                [self clearBtn:nil];
                                            }
                                        }];
                    }];
                }
                else{
                    NSLog(@"Invalid Input: Add Recipe");
                }
            }];
        }
    }
}
// add a new image to the recipe
- (IBAction)addPicture:(id)sender {
    UIAlertController *e=[UIAlertController alertControllerWithTitle:@"UplaodImage" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [e addAction:[UIAlertAction actionWithTitle:@"Library Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * a){
        //if the user choose to pick a photo from the image library
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate=self;
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self.parentViewController presentViewController:imagePicker animated:YES completion:nil];
        }}]];
    [e addAction:[UIAlertAction actionWithTitle:@"Camera Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * a){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate=self;
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self.parentViewController presentViewController:imagePicker animated:YES completion:nil];
        }else
        {
            UIAlertController *e=[UIAlertController alertControllerWithTitle:@"Error accessing Camera" message:@"Device does not support the camera" preferredStyle:UIAlertControllerStyleAlert];
            [e addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self.parentViewController presentViewController:e animated:YES completion:nil];
        }}]];
    
        [e addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * a){
        [e dismissViewControllerAnimated:YES completion:nil];}]];
    
       [self presentViewController:e animated:YES completion:nil];
   
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
   // NSURL *imageFileURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    [self.imageView setImage:image];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

// The number of columns of data
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// The number of rows of data
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [categoryPickerData count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return categoryPickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   // NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.categoryName attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.categoryName=categoryPickerData[row];

    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *category = categoryPickerData[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:category attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
}

-(Boolean)checkData{
    // Get the username text, store it in the app delegate for now
    NSString *recipeNameText = self.recipeNameText.text;
    NSString *ingredientsText = self.ingredientsText.text;
    NSString *directionsText = self.directionsText.text;
    // Messaging nil will return 0, so these checks implicitly check for nil text.
    if (recipeNameText.length == 0 || ingredientsText.length == 0 || directionsText.length ==0 || self.imageView.image ==nil) {
        // Set up the keyboard for the first field missing input:
        if (recipeNameText.length == 0) {
            [self.recipeNameText becomeFirstResponder];
            return NO;
        }
        if (ingredientsText.length == 0) {
            [self.ingredientsText becomeFirstResponder];
            return NO;
        }
        if (directionsText.length ==0) {
            [self.directionsText becomeFirstResponder];
            return NO;
        }
        if (self.imageView.image == nil) {
            [self.imageView becomeFirstResponder];
            return NO;
        }
    }
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    if(self.imageView.image==nil)
    {
    [self clearBtn:nil];
    }
}
@end
