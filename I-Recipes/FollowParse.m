//
//  FollowParse.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "FollowParse.h"

@implementation FollowParse

//adding the recipe's writer to the current user's follow list in Parse
-(void)addFollow: (Follow*)follow{
    PFObject* obj = [PFObject objectWithClassName:@"Follow"];
    obj[@"follower"] = follow.follower;
    obj[@"beingFollowed"]=follow.beingFollowed;
    [obj save];
}
//get all the follow objects (row in the follow table user-ID user-ID) of the received user from Parse
-(NSMutableArray*)getFollow:user{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Follow"];
    [query whereKey:@"follower" equalTo:user];
    NSArray* res = [query findObjects];
    for(PFObject* obj in res){
        Follow* follow = [[Follow alloc] init:obj[@"follower"] beingFollowed:obj[@"beingFollowed"]];
        [array addObject:follow];
    }
    return array;
}
//get all the recipes of the received user from Parse
-(NSMutableArray*)getFollowRecipes:(NSString*)user{
   NSMutableArray* array = [[NSMutableArray alloc] init];
    //NSMutableArray* allFollowRecipe = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Follow"];
    [query whereKey:@"follower" equalTo:user];
    NSArray* res = [query findObjects];
    
    for(PFObject* obj in res){
        [array addObject:obj[@"beingFollowed"]];
    }
    return array;
}

//-(NSMutableArray*)getRecipeFromUser:(NSString*)user{
//    NSMutableArray* array = [[NSMutableArray alloc] init];
//    PFQuery* query = [PFQuery queryWithClassName:@"Recipes"];
//    [query whereKey:@"user" equalTo:user];
//    NSArray* res = [query findObjects];
//    for (PFObject* obj in res) {
//        Recipe* recipe = [[Recipe alloc] init:obj[@"recipeName"] ingredients:obj[@"ingredients"] directions:obj[@"directions"] imageName:obj[@"imageName"] categoryName:obj[@"categoryName"] user:obj[@"user"] recipeId:obj.objectId];
//        [array addObject:recipe];
//    }
//    return array;
//}
//get all the follows rows in table that were saved in Parse from a certain data (latest SQL update in Ephoc time)
-(NSArray*)getFollowFromDate:(NSString *)date{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Follow"];
    NSDate* dated = [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
    [query whereKey:@"updatedAt" greaterThanOrEqualTo:dated];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Follow* follow = [[Follow alloc] init:obj[@"follower"] beingFollowed:obj[@"beingFollowed"]];
        [array addObject:follow];
    }
    return array;
}
@end
