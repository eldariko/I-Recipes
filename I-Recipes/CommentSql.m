//
//  CommentSql.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "CommentSql.h"

@implementation CommentSql
static NSString* COMMENT_TABLE = @"COMMENTS";
static NSString* RECIPE_ID = @"RECIPE_ID";
static NSString* COMMENT = @"COMMENT";
static NSString* USER_ID = @"USER_ID";


+(BOOL)createTable:(sqlite3*)database{
    char* errormsg;
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT,%@ TEXT, %@ TEXT)",COMMENT_TABLE,RECIPE_ID,COMMENT,USER_ID];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed creating COMMENTS table");
        return NO;
    }
    return YES;
}

+(void)addComment:(sqlite3 *)database comment:(Comment *)comment{
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@,%@) values (?,?,?);",COMMENT_TABLE,RECIPE_ID,COMMENT,USER_ID];
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [comment.recipeId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [comment.comment UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 3, [comment.userId UTF8String],-1,NULL);

        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addComment failed %s",sqlite3_errmsg(database));
}
+(NSString*)getCommentsLastUpdateDate:(sqlite3*)database{
    return [LastUpdateSql getLastUpdateDate:database forTable:COMMENT_TABLE];
}

+(void)setCommentsLastUpdateDate:(sqlite3*)database date:(NSString*)date{
    [LastUpdateSql setLastUpdateDate:database date:date forTable:COMMENT_TABLE];
}
+(NSArray*)getCommentRecipe:(sqlite3*)database :(NSString*)recipeId{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from COMMENTS where RECIPE_ID = ?;"];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [recipeId UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* recipeId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* comment = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* userId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            Comment* commentObj =[[Comment alloc]init:recipeId comment:comment userId:userId];
            [data addObject:commentObj];
        }
    }else{
        NSLog(@"ERROR: getComments failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
    
}

+(void)updateComments:(sqlite3*)database comment:(NSArray*)comment{
    for (Comment* c in comment) {
        [CommentSql addComment:database comment:c];
    }
}
@end
