//
//  ModelSql.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/15.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ModelSql.h"
#import "RecipeSql.h"
#import "LastUpdateSql.h"
#import "FavoriteSql.h"
#import "CommentSql.h"
#import "Favorites.h"
#import "FollowSql.h"

@interface ModelSql : NSObject{
    sqlite3* database;
}

-(void)addRecipe:(Recipe*)recipe; //calls the addRecipe func from the RecipeSql class
-(void)setRecipesLastUpdateDate:(NSString*)date; //calls the setRecipesLastUpdateDate func from the RecipeSql class
-(NSString*)getRecipesLastUpdateDate; //calls the getRecipesLastUpdateDate func from the RecipeSql class
-(void)updateRecipes:(NSArray*)recipes; //calls the updateRecipes func from the RecipeSql class
-(NSArray*)getRecipes; //calls the getRecipes func from RecipeSql class
-(NSArray*)getMyRecipes:(NSString*)user; //calls the getMyRecipes func from RecipeSql class
-(NSArray*)getRecipeCategory:(NSString*)category; //calls the getRecipeCategory func from RecipeSql class


-(void)addFavorite:(Favorites*)favorite; //calls the addFavorite func from the FavoriteSql class
-(void)setFavoritesLastUpdateDate:(NSString*)date; //calls the setFavoritesLastUpdateDate func from the FavoriteSql class
-(NSString*)getFavoriteLastUpdateDate; //calls the getFavoriteLastUpdateDate func from the FavoriteSql class
-(void)updateFavorites:(NSArray*)favorites; //calls the updateFavorites func from the FavoriteSql class
-(NSArray*)getFavoriteRecipe:(NSString*)user; //calls the getFavoriteRecipe func from the FavoriteSql class


-(void)addComment:(Comment*)comment; //calls the addComment func from the CommentSql class
-(void)setCommentsLastUpdateDate:(NSString*)date; //calls the setCommentsLastUpdateDate func from the CommentSql class
-(NSString*)getCommentsLastUpdateDate; //calls the getCommentsLastUpdateDate func from the CommentSql class
-(void)updateComments:(NSArray*)comment; //calls the updateComments func from the CommentSql class
-(NSArray*)getCommentsRecipe:(NSString*)recipeId; //calls the getCommentsRecipe func from the CommentSql class


-(void)addFollow: (Follow*)follow; //calls the addFollow func from the FollowSql class
-(void)setFollowLastUpdateDate:(NSString*)date; //calls the setFollowLastUpdateDate func from the FollowSql class
-(NSString*)getFollowLastUpdateDate; //calls the getFollowLastUpdateDate func from the FollowSql class
-(void)updateFollow:(NSArray*)follow; //calls the updateFollow func from the FollowSql class
-(NSArray*)getFollowRecipe:(NSString*)user; //calls the getFollowRecipe func from the FollowSql class
-(NSArray*)getFollow:(NSString*)user; //calls the getFollow func from the FollowSql class
@end
