//
//  ModelParse.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
@interface ModelParse : NSObject

@property NSString* errorString;

-(void)addRecipe:(Recipe*)recipe; //calls the addRecipe func from the RecipeParse class
-(NSArray*)getRecipesFromDate:(NSString*)date; //calls the getRecipesFromDate func from the RecipeParse class
-(NSMutableArray*)getRecipes; //calls the getRecipes func from the RecipeParse class
-(NSMutableArray*)getRecipeCategory:(NSString*)category; //calls the getRecipeCategory func from the RecipeParse class
-(NSMutableArray*)getMyRecipes; //calls the getMyRecipes func from the RecipeParse class


-(void)addComment:(Comment*)comment; //calls the addComment func from the CommentParse class
-(NSArray*)getCommentsFromDate:(NSString*)date; //calls the getCommentsFromDate func from the CommentParse class
-(NSMutableArray*)getComments:(NSString*)recipeId; //calls the getComments func from the CommentParse class


-(void)addFavorite:(Favorites*)favorite; //calls the addFavorite func from the FavoriteParse class
-(NSArray*)getFavoriteFromDate:(NSString*)date; //calls the getFavoriteFromDate func from the FavoriteParse class
-(NSMutableArray*)getFavorite:(NSString*)user; //calls the getFavoriteFromDate func from the FavoriteParse class
-(NSMutableArray*)getFavoriteRecipes:(NSString*)user; //get all the favorite recipes of the received user from Parse


-(void)addFollow: (Follow*)follow; //calls the addFollow func from the FollowParse class
-(NSArray*)getFollowFromDate:(NSString*)date; //calls the getFollowFromDate func from the FollowParse class
-(NSMutableArray*)getFollow:(NSString*)user; //calls the getFollow func from the FollowParse class
-(NSMutableArray*)getFollowRecipes:(NSString*)user; //calls the getFollowRecipes func from the FollowParse class


-(void)saveImage:(UIImage*)image withName:(NSString*)imageName; //saves the image name in Parse
-(UIImage*)getImage:(NSString*)imageName; //get the image itself from the image name


-(NSError*)login:(NSString*)user pwd:(NSString*)pwd; //login
-(void)logOut; //logout
-(NSError*)signup:(NSString*)email userName:(NSString*)user pwd:(NSString*)pwd; //register a new user
-(BOOL)resetPassword:(NSString*)email; //reset password
-(NSString*)getCurrentUserId; //get the current user ID as saved in Parse
-(NSString*)getUserName:(NSString*)userId; //retrieves the user name from the user ID
-(NSString*)getUserName;
-(NSString*)getEmail;
@end
