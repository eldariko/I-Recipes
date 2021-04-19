//
//  ModelSql.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/15.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//
//

#import "ModelSQL.h"

@implementation ModelSql

-(id)init{
    self = [super init];
    if (self) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSArray* paths = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL* directoryUrl = [paths objectAtIndex:0];
        NSURL* fileUrl = [directoryUrl URLByAppendingPathComponent:@"database.db"];
        NSString* filePath = [fileUrl path];
        const char* cFilePath = [filePath UTF8String];
        int res = sqlite3_open(cFilePath,&database);
        if(res != SQLITE_OK){
            NSLog(@"ERROR: fail to open db");
            database = nil;
        }
        [RecipeSql createTable:database];
        [FavoriteSql createTable:database];
        [CommentSql createTable:database];
        [FollowSql createTable:database];
        [LastUpdateSql createTable:database];
    }
    return self;
}

//Add - Recipe,Favorite,Follow,Comment
-(void)addRecipe:(Recipe*)recipe{
    [RecipeSql addRecipe:database recipe:recipe];
}
-(void)addFavorite:(Favorites*)favorite{
    [FavoriteSql addFavorite:database favorite:favorite];
}
-(void)addFollow:(Follow*)follow{
    [FollowSql addFollow:database follow:follow];
}
-(void)addComment:(Comment*)comment{
    [CommentSql addComment:database comment:comment];
}


//Set Last Update Date- Recipe,Favorite,Follow,Comment
-(void)setRecipesLastUpdateDate:(NSString*)date{
    [RecipeSql setRecipesLastUpdateDate:database date:date];
}
-(void)setFavoritesLastUpdateDate:(NSString*)date{
    [FavoriteSql setFavoritesLastUpdateDate:database date:date];
}
-(void)setFollowLastUpdateDate:(NSString*)date{
    [FollowSql setFollowLastUpdateDate:database date:date];
}
-(void)setCommentsLastUpdateDate:(NSString*)date{
     [CommentSql setCommentsLastUpdateDate:database date:date];
}


//Get Last Update Date - Recipe,Favorite,Follow,Comment
-(NSString*)getRecipesLastUpdateDate{
    return [RecipeSql getRecipesLastUpdateDate:database];
}
-(NSString*)getFavoriteLastUpdateDate{
    return [FavoriteSql getFavoritesLastUpdateDate:database];
}
-(NSString*)getFollowLastUpdateDate{
    return [FollowSql getFollowLastUpdateDate:database];
}
-(NSString*)getCommentsLastUpdateDate{
    return [CommentSql getCommentsLastUpdateDate:database];
}

//Update-Recipe,Favorite,Follow,Comment
-(void)updateRecipes:(NSArray*)recipes{
    [RecipeSql updateRecipes:database recipes:recipes];
}
-(void)updateFavorites:(NSArray*)favorites{
    [FavoriteSql updateFavorites:database favorite:favorites];
}
-(void)updateFollow:(NSArray*)follow{
    [FollowSql updateFollow:database follow:follow];
}
-(void)updateComments:(NSArray*)comment{
    [CommentSql updateComments:database comment:comment];
}

//get
-(NSArray*)getRecipes{
    return [RecipeSql getRecipes:database];
}
-(NSArray*)getRecipeCategory:(NSString*)category{
    return [RecipeSql getRecipeCategory:database:category];
}
-(NSArray*)getMyRecipes:(NSString*)user{
    return [RecipeSql getMyRecipes:database:user];
}
-(NSArray*)getFavoriteRecipe:(NSString*)user{
    return [FavoriteSql getFavoriteRecipe:database:user];
}
-(NSArray*)getFollowRecipe:(NSString*)user{
    return [FollowSql getFollowRecipe:database:user];
}
-(NSArray*)getFollow:(NSString*)user{
    return [FollowSql getFollow:database :user];
}
-(NSArray*)getCommentsRecipe:(NSString*)recipeId{
    return [CommentSql getCommentRecipe:database:recipeId];
}
@end
