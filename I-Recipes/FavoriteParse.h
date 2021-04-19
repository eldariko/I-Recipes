//
//  FavoriteParse.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "Favorites.h"
@interface FavoriteParse : NSObject
-(void)addFavorite:(Favorites*)favorite; //add the current recipe the the current user's "favorites" list and save it in Parse.
-(NSArray*)getFavoriteFromDate:(NSString *)date; //get all the favorite recipes that were saved in Parse from a certain data (latest SQL update in Ephoc time)
-(NSMutableArray*)getFavorite:user; //get all the favorite objects (row in the favorite table user-ID recipe-ID) of the received user from Parse
-(NSMutableArray*)getFavoriteRecipes:(NSString*)user; //get all the favorite recipes of the received user from Parse
-(Recipe*)getRecipeFromUniqueId:(NSString*)uniqueId;
@end
