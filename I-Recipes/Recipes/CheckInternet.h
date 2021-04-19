//
//  CheckInternet.h
//  Recipes
//
//  The class functionality is to return Boolean that indicates whether there is or there is no Internet connection available.
//  In case there is no Internet connection, it pops up an alert to the user to the provided UIViewController.
//
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 11/01/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CheckInternet : NSObject
+(BOOL)checkInternet:(UIViewController*)controller; //func that checks whether Internet connection is available, otherwise it pops up an alert to the provided UIViewController
@end
