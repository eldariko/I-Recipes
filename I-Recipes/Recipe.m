//
//  Recipe.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

//initialize the recipes' information
-(id)init:(NSString*)recipeName ingredients:(NSString*)ingredients directions:(NSString*)directions imageName:(NSString*)imageName categoryName:(NSString*)categoryName user:(NSString*)user{
    self = [super init];
    if (self){
        _recipeName = recipeName;
        _ingredients = ingredients;
        _directions = directions;
        _imageName=[NSString stringWithFormat:@"%@.png",self.recipeName];
        _categoryName=categoryName;
        _user=user;
    }
    return self;
}
//initialize the recipes' information after the initialization in Parse- with recipeID
-(id)init:(NSString*)recipeName ingredients:(NSString*)ingredients directions:(NSString*)directions imageName:(NSString*)imageName categoryName:(NSString*)categoryName user:(NSString*)user recipeId:(NSString*)recipeId{
    self = [super init];
    if (self){
        _recipeName = recipeName;
        _ingredients = ingredients;
        _directions = directions;
        _imageName=[NSString stringWithFormat:@"%@.png",self.recipeName];
        _categoryName=categoryName;
        _user=user;
        _recipeId=recipeId;
    }
    return self;
}
@end
