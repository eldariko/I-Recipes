//
//  CommentSql.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import <sqlite3.h>
#import "LastUpdateSql.h"
@interface CommentSql : NSObject

+(BOOL)createTable:(sqlite3*)database; //creates the "Comments" table in the SQL database
+(void)addComment:(sqlite3*)database comment:(Comment*)comment; //add a new comment to a recipe and save this comment in SQL
+(void)setCommentsLastUpdateDate:(sqlite3*)database date:(NSString*)date;// calls the setLastUpdateDate from LastUpdateDate class
+(NSString*)getCommentsLastUpdateDate:(sqlite3*)database; //calls the getLastUpdateDate func from LastUpdateSql class
+(void)updateComments:(sqlite3*)database comment:(NSArray*)comment;//receives an array of comments and calls the addComment func
+(NSArray*)getCommentRecipe:(sqlite3*)database :(NSString*)recipeId; //retrives all the comments related to the recipe ID
@end
