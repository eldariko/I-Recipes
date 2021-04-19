//
//  FollowParse.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Follow.h"
#import <Parse/Parse.h>
#import "Recipe.h"
@interface FollowParse : NSObject

-(void)addFollow: (Follow*)follow; //adding the recipe's writer to the current user's follow list in Parse
-(NSMutableArray*)getFollow:user; //get all the follow objects (row in the follow table user-ID user-ID) of the received user from Parse
-(NSMutableArray*)getFollowRecipes:(NSString*)user; //get all the recipes of the received user from Parse
//-(NSMutableArray*)getRecipeFromUser:(NSString*)user;
-(NSArray*)getFollowFromDate:(NSString *)date; //get all the follows rows in table that were saved in Parse from a certain data (latest SQL update in Ephoc time)
@end
