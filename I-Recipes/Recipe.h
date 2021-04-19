//
//  Recipe.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Recipe : NSObject
@property NSString* recipeId;
@property NSString* recipeName;
@property NSString* ingredients;
@property NSString* directions;
@property NSString* imageName;
@property NSString* categoryName;
@property NSString* user;

//initialize the recipes' information 
-(id)init:(NSString*)recipeName ingredients:(NSString*)ingredients directions:(NSString*)directions imageName:(NSString*)imageName categoryName:(NSString*)categoryName user:(NSString*)user;
//initialize the recipes' information after the initialization in Parse- with recipeID
-(id)init:(NSString*)recipeName ingredients:(NSString*)ingredients directions:(NSString*)directions imageName:(NSString*)imageName categoryName:(NSString*)categoryName user:(NSString*)user recipeId:(NSString*)recipeId;
@end

