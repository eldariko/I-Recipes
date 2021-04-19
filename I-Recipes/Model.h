//
//  Model.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "Recipe.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Comment.h"
#import "Favorites.h"
#import "Follow.h"
#import <unistd.h>
#import <netdb.h>
@interface Model : NSObject {

}
@property NSString* user;
+(Model*)instance;

//func add to parse
-(void)addRecipeAsynch:(Recipe*)recipe block:(void(^)(BOOL))block;
-(void)addCommentAsynch:(Comment*)comment block:(void(^)(BOOL))block;
-(void)addFavoriteAsynch:(Favorites*)favorite block:(void(^)(BOOL))block;
-(void)addFollowAsynch:(Follow*)follow block:(void(^)(BOOL))block;

//func login-signUp
-(void)login:(NSString*)name pwd:(NSString*)pwd block:(void(^)(NSError*))block;
-(void)logOut:(void(^)(void))block;
-(NSError*)signup:(NSString*)email userName:(NSString*)user pwd:(NSString*)pwd;
-(void)signup:(NSString*)email userName:(NSString*)user pwd:(NSString*)pwd block:(void(^)(NSError*))block;
-(void)resetPassword:(NSString*)email block:(void(^)(bool))block;

//func get recipe by
-(void)getRecipesAsynch:(void(^)(NSArray*))block;
-(void)getRecipesCategoryAsynch:(NSString*)category :(void(^)(NSArray*))block;
-(void)getFavoriteRecipesAsynch:(void(^)(NSArray*))block;

-(void)getFollowRecipesAsynch:(void(^)(NSMutableArray*))block;
-(void)getCommentsAsynch:(NSString*)recipeId :(void(^)(NSMutableArray*))block;
-(void)getMyRecipesAsynch:(NSString*)forSpecificUser withblock:(void(^)(NSMutableArray*))block;
//-(NSString*)getCurrentUserIdAsync:(void(^)(NSString*))block;

-(BOOL)isNetworkAvailable;
-(NSString*)getCurrentUserId ;
-(void)setCurrentUserName:(NSString*)user;
-(NSString*)getUserName;
-(void)getUserName:(NSString*)user block:(void(^)(NSString* name))block;
-(void)getUserNameAndMail:(void(^)(NSString* name,NSString* mail))block;

//func for image
-(void)getRecipeImage:(Recipe*)st block:(void(^)(UIImage*))block;
-(void)saveRecipeImage:(Recipe*)st image:(UIImage*)image block:(void(^)(NSError*))block;

@end
