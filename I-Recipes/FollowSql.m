//
//  FollowSql.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "FollowSql.h"

@implementation FollowSql

static NSString* FOLLOW_TABLE = @"FOLLOW";
static NSString* FOLLOWER = @"FOLLOWER";
static NSString* BEING_FOLLOWED = @"BEING_FOLLOWED";
static NSString* RECIPE_TABLE = @"RECIPES";
static NSString* RECIPE_USER_ID = @"USER_ID";
+(BOOL)createTable:(sqlite3*)database{
    char* errormsg;
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT, %@ TEXT)",FOLLOW_TABLE,FOLLOWER ,BEING_FOLLOWED];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed creating FOLLOW table");
        return NO;
    }
    return YES;
}
+(void)addFollow:(sqlite3 *)database follow:(Follow *)follow{
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@) values (?,?);",FOLLOW_TABLE,FOLLOWER ,BEING_FOLLOWED];
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [follow.follower UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [follow.beingFollowed UTF8String],-1,NULL);
        
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addFollow failed %s",sqlite3_errmsg(database));
}
+(NSString*)getFollowLastUpdateDate:(sqlite3*)database{
    return [LastUpdateSql getLastUpdateDate:database forTable:FOLLOW_TABLE];
}

+(void)setFollowLastUpdateDate:(sqlite3*)database date:(NSString*)date{
    [LastUpdateSql setLastUpdateDate:database date:date forTable:FOLLOW_TABLE];
}
+(void)updateFollow:(sqlite3*)database follow:(NSArray*)follow{
    for (Follow* f in follow) {
        [FollowSql addFollow:database follow:f];
    }
}
+(NSArray*)getFollow:(sqlite3*)database :(NSString*)user{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",FOLLOW_TABLE,FOLLOWER];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [user UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* follower = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* beingFollowed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            Follow* follow=[[Follow alloc]init:follower beingFollowed:beingFollowed];
            [data addObject:follow];
        }
        
    }else{
        NSLog(@"ERROR: getFavorite failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
}
//user-follower
+(NSArray*)getFollowRecipe:(sqlite3*)database :(NSString*)user{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",FOLLOW_TABLE,FOLLOWER];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [user UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            //NSString* follower = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* beingFollowed = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            [data addObject:[FollowSql getRecipeFromUser:database :beingFollowed]];
        }
        
    }else{
        NSLog(@"ERROR: getFavorite failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
}
+(Recipe*)getRecipeFromUser:(sqlite3*)database :(NSString*)user{
    Recipe* recipe=[[Recipe alloc]init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",RECIPE_TABLE,RECIPE_USER_ID];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [user UTF8String],-1,NULL);
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
@end
