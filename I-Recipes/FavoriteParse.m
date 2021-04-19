//
//  FavoriteParse.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "FavoriteParse.h"
#import <Parse/Parse.h>
#import "Recipe.h"
#import "Favorites.h"
@implementation FavoriteParse

//add the current recipe the the current user's "favorites" list and save it in Parse.
-(void)addFavorite:(Favorites*)favorite{
    PFObject* obj = [PFObject objectWithClassName:@"Favorite"];
    obj[@"recipe"] = favorite.recipeId;
    obj[@"user"] = favorite.user;
    [obj save];
}
//get all the favorite objects (row in the favorite table user-ID recipe-ID) of the received user from Parse
-(NSMutableArray*)getFavorite:user{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Favorite"];
    [query whereKey:@"user" equalTo:user];
    NSArray* res = [query findObjects];
    for(PFObject* obj in res){
        Favorites* favorite = [[Favorites alloc] init:obj[@"recipe"]user:obj[@"user"]];
        [array addObject:favorite];
    }
    return array;
}
//get all the favorite recipes of the received user from Parse
-(NSMutableArray*)getFavoriteRecipes:(NSString*)user{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Favorite"];
    [query whereKey:@"user" equalTo:user];
    NSArray* res = [query findObjects];
    for(PFObject* obj in res){
        [array addObject:[self getRecipeFromUniqueId:obj[@"recipe"]]];
    }
    return array;
}
-(Recipe*)getRecipeFromUniqueId:(NSString*)uniqueId{
    PFQuery* query = [PFQuery queryWithClassName:@"Recipes"];
    [query whereKey:@"objectId" equalTo:uniqueId];
    NSArray* res = [query findObjects];
    if(res.count==1){
        PFObject* obj = [res objectAtIndex:0];
        Recipe* recipe = [[Recipe alloc] init:obj[@"recipeName"] ingredients:obj[@"ingredients"] directions:obj[@"directions"] imageName:obj[@"imageName"] categoryName:obj[@"categoryName"] user:obj[@"user"] recipeId:obj.objectId];
        return recipe;
    }
    else{
        return nil;
    }
}
//get all the favorite recipes that were saved in Parse from a certain data (latest SQL update in Ephoc time)
-(NSArray*)getFavoriteFromDate:(NSString *)date{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Favorite"];
    NSDate* dated = [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
    [query whereKey:@"updatedAt" greaterThanOrEqualTo:dated];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Favorites* favorite = [[Favorites alloc] init:obj[@"recipe"]user:obj[@"user"]];
        [array addObject:favorite];
    }
    return array;
}
@end
