//
//  FollowSql.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Follow.h"
#import "Recipe.h"
#import "LastUpdateSql.h"
@interface FollowSql : NSObject

+(BOOL)createTable:(sqlite3*)database; //creates the "Follow" table in the SQL database
+(void)addFollow:(sqlite3 *)database follow:(Follow *)follow; //adding the recipe's writer to the current user's follow list in SQL
+(void)setFollowLastUpdateDate:(sqlite3*)database date:(NSString*)date;// calls the setLastUpdateDate from LastUpdateDate class
+(NSString*)getFollowLastUpdateDate:(sqlite3*)database;//calls the getLastUpdateDate func from LastUpdateSql class
+(NSArray*)getFollowRecipe:(sqlite3*)database :(NSString*)user; //get all the revipes of the user
+(NSArray*)getFollow:(sqlite3*)database :(NSString*)user; //retrives all the "follow" objects which are being followed by the current user
+(void)updateFollow:(sqlite3*)database follow:(NSArray*)follow; //receives an array of follow and calls the addFollow func
+(Recipe*)getRecipeFromUser:(sqlite3*)database :(NSString*)user;//retrives all the recipes related to the user ID

@end
