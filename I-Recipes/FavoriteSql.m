//
//  FavoriteSql.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "FavoriteSql.h"
#import "Recipe.h"
@implementation FavoriteSql
static NSString* FAVORITES_TABLE = @"FAVORITES";
static NSString* RECIPE_ID = @"RECIPE_ID";
static NSString* USER_ID = @"USER_ID";
static NSString* RECIPE_TABLE = @"RECIPES";

+(BOOL)createTable:(sqlite3*)database{
    char* errormsg;
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT,%@ TEXT)",FAVORITES_TABLE ,RECIPE_ID,USER_ID];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed creating RECIPES table");
        return NO;
    }
    return YES;
}

+(void)addFavorite:(sqlite3 *)database favorite:(Favorites *)favorite{
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@) values (?,?);",FAVORITES_TABLE ,RECIPE_ID,USER_ID];
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [favorite.recipeId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [favorite.user UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    NSLog(@"ERROR: addRecipe failed %s",sqlite3_errmsg(database));
}

+(NSArray*)getFavoriteRecipe:(sqlite3*)database :(NSString*)user{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",FAVORITES_TABLE,USER_ID];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [user UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* recipeId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            [data addObject:[self getRecipeFromUniqueId:database :recipeId]];
        }

    }else{
        NSLog(@"ERROR: getFavorite failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
}

+(Recipe*)getRecipeFromUniqueId:(sqlite3*)database :(NSString*)uniqueId{
    Recipe* recipe=[[Recipe alloc]init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",RECIPE_TABLE,RECIPE_ID];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [uniqueId UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* recipeId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* recipeName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* categoryName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            NSString* ingredients = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            NSString* directions = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            NSString* imageName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,5)];
            NSString* user = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,6)];
            recipe = [[Recipe alloc] init:recipeName ingredients:ingredients directions:directions imageName:imageName categoryName:categoryName user:user recipeId:recipeId];
            return recipe;
        }
    }else{
        NSLog(@"ERROR: getFavorite failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return recipe;
}
+(NSString*)getFavoritesLastUpdateDate:(sqlite3*)database{
    return [LastUpdateSql getLastUpdateDate:database forTable:FAVORITES_TABLE];
}

+(void)setFavoritesLastUpdateDate:(sqlite3*)database date:(NSString*)date{
    [LastUpdateSql setLastUpdateDate:database date:date forTable:FAVORITES_TABLE];
}
+(void)updateFavorites:(sqlite3*)database favorite:(NSArray*)favorite{
    for (Favorites* f in favorite) {
        [FavoriteSql addFavorite:database favorite:f];
    }
}
@end
