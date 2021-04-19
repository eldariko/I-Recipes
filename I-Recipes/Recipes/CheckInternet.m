//
//  CheckInternet.m
//  Recipes
//
//  Created by Lital Zigron on 11/01/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "CheckInternet.h"
#import "Model.h"
@implementation CheckInternet
+(BOOL)checkInternet:(UIViewController*)controller{
    if([[Model instance]isNetworkAvailable])
    {
        return YES;
    }
    else
    {
        UIAlertController *e=[UIAlertController alertControllerWithTitle:@"Error" message:@"No Internet Connection" preferredStyle:UIAlertControllerStyleAlert];
        [e addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * a){
            [e dismissViewControllerAnimated:YES completion:nil];
        }]];
        [controller presentViewController:e animated:YES completion:nil];
        return NO;
    }
}
@end
