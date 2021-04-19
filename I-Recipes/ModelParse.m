//
//  ModelParse.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 27/12/15.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//
#import "ModelParse.h"
#import <sqlite3.h>
#import "ModelSql.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Favorites.h"
#import "RecipeParse.h"
#import "FavoriteParse.h"
#import "Comment.h"
#import "FollowParse.h"
#import "CommentParse.h"
#import "FavoriteParse.h"
@implementation ModelParse{
    RecipeParse* recipeParseModelImpl;
    FavoriteParse* favoriteParseModelImpl;
    FollowParse* followParseModelImpl;
    CommentParse* commentParseModelImpl;
}
-(id)init{
    self = [super init];
    if (self) {
        [Parse setApplicationId:@"LoN9kTN2Xxok9COgGmzxDOVXxVc6ofgom3FhDiZp"
                      clientKey:@"ufCl5856cVg9YK9ZcEIwvGTq2TsD7wPqdfFTu7yl"];
        recipeParseModelImpl=[[RecipeParse alloc]init];
         favoriteParseModelImpl=[[FavoriteParse alloc]init];
         followParseModelImpl=[[FollowParse alloc]init];
        commentParseModelImpl=[[CommentParse alloc]init];
    }
    return self;
}


-(NSError*)login:(NSString*)user pwd:(NSString*)pwd
{
    NSError* error;
    PFUser* puser = [PFUser logInWithUsername:user password:pwd error:&error];
    if (error == nil && puser != nil) {
        return nil;
    }
    else return error;
}
-(void)logOut{
    [PFUser logOut];
}
//register a new user
-(NSError*)signup:(NSString*)email userName:(NSString*)user pwd:(NSString*)pwd{
    NSError* error;
    PFUser* puser = [PFUser user];
    puser.email=email;
    puser.username = user;
    puser.password = pwd;
    [puser signUp:&error];
    if(error == nil && puser != nil)
        return nil;
    else return error;
}
//reset password
-(BOOL)resetPassword:(NSString*)email {
    return [PFUser requestPasswordResetForEmail:email];
}
//saves the image name in Parse
-(void)saveImage:(UIImage*)image withName:(NSString*)imageName{
    NSData* imageData = UIImageJPEGRepresentation(image,0.10);
    PFFile* file = [PFFile fileWithName:imageName data:imageData];
    PFObject* fileobj = [PFObject objectWithClassName:@"Images"];
    fileobj[@"imageName"] = imageName;
    fileobj[@"file"] = file;
    [fileobj save];
}
//get the image itself from the image name
-(UIImage*)getImage:(NSString*)imageName{
    PFQuery* query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"imageName" equalTo:imageName];
    NSArray* res = [query findObjects];
    UIImage* image = nil;
    if(res.count>0)
    {
    PFObject* imObj = [res objectAtIndex:0];
    PFFile* file = imObj[@"file"];
    NSData* data = [file getData];
    image = [UIImage imageWithData:data];
    }
    return image;
}
-(NSString*)getUserName{
    PFUser *currentUser = [PFUser currentUser];
    return currentUser.username;
}
//retrieves the user name from the user ID
-(NSString*)getUserName:(NSString*)userId{
    PFUser* puser=[PFQuery getUserObjectWithId:userId];
    return puser.username;
}
//calls the getRecipesFromDate func from the RecipeParse class
-(NSArray*)getRecipesFromDate:(NSString*)date{
    return [recipeParseModelImpl getRecipesFromDate:date];
}
//calls the getCommentsFromDate func from the CommentParse class
-(NSArray*)getCommentsFromDate:(NSString*)date{
    return [commentParseModelImpl getCommentsFromDate:date];
}
//calls the getFollowFromDate func from the FollowParse class
-(NSArray*)getFollowFromDate:(NSString *)date{
    return [followParseModelImpl getFollowFromDate:date];
}
//calls the getFavoriteFromDate func from the FavoriteParse class
-(NSArray*)getFavoriteFromDate:(NSString *)date{
    return [favoriteParseModelImpl getFavoriteFromDate:date];
}
//get the current user ID as saved in Parse
-(NSString*)getCurrentUserId{
    PFUser *currentUser = [PFUser currentUser];
    return currentUser.objectId;
}

-(NSString *)getEmail{
    return [PFUser currentUser].email;
}

//calls the addFollow func from the FollowParse class
-(void)addFollow:(Follow*)follow{
    [followParseModelImpl addFollow:follow];
}
//calls the addFavorite func from the FavoriteParse class
-(void)addFavorite:(Favorites*)favorite{
    [favoriteParseModelImpl addFavorite:favorite];
}
//calls the addRecipe func from the RecipeParse class
-(void)addRecipe:(Recipe*)recipe{
    [recipeParseModelImpl addRecipe:recipe];
}
//calls the addComment func from the CommentParse class
-(void)addComment:(Comment*)comment{
    [commentParseModelImpl addComment:comment];
}
//calls the getComments func from the CommentParse class
-(NSMutableArray*)getComments:(NSString*)recipeId{
    return [commentParseModelImpl getComments:recipeId];
}
 //calls the getFavoriteFromDate func from the FavoriteParse class
-(NSMutableArray*)getFavorite:(NSString*)user{
    return [favoriteParseModelImpl getFavorite:user];
}
//calls the getFollow func from the FollowParse class
-(NSMutableArray*)getFollow:(NSString*)user{
    return [followParseModelImpl getFollow:user];
}
//get all the favorite recipes of the received user from Parse
-(NSMutableArray*)getFavoriteRecipes:(NSString*)user{
    return [favoriteParseModelImpl getFavoriteRecipes:user];
}
//calls the getFollowRecipes func from the FollowParse class
-(NSMutableArray*)getFollowRecipes:(NSString*)user{
    return [followParseModelImpl getFollowRecipes:user];
}
//calls the getRecipeCategory func from the RecipeParse class
-(NSMutableArray*)getRecipeCategory:(NSString*)category{
    return [recipeParseModelImpl getRecipeCategory:category];
}
//calls the getMyRecipes func from the RecipeParse class
-(NSMutableArray*)getMyRecipes{
    return [recipeParseModelImpl getMyRecipes];
}
//calls the getRecipes func from the RecipeParse class
-(NSMutableArray*)getRecipes{
    return [recipeParseModelImpl getRecipes];
}
@end
