//
//  FavoriteSql.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Favorites.h"
#import "LastUpdateSql.h"
#import "Recipe.h"
@interface FavoriteSql : NSObject

+(BOOL)createTable:(sqlite3*)database; //creates the "Favorite" table in the SQL database
+(void)addFavorite:(sqlite3 *)database favorite:(Favorites *)favorite; //add the favorite Favorites * as a new favorite to SQL
+(void)setFavoritesLastUpdateDate:(sqlite3*)database date:(NSString*)date; //calls the setLastUpdateDate from LastUpdateDate class
+(NSString*)getFavoritesLastUpdateDate:(sqlite3*)database; //calls the getLastUpdateDate func from LastUpdateSql class
+(NSArray*)getFavoriteRecipe:(sqlite3*)database :(NSString*)user; //retrives all the favorite recipes of the recives user
+(void)updateFavorites:(sqlite3*)database favorite:(NSArray*)favorite; //receives an array of favorite and calls the addFavorite func

//+(Recipe*)getRecipeFromUniqueId:(sqlite3*)database :(NSString*)uniqueId;
@end