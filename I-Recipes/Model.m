//
//  Model.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "Model.h"
#import <sqlite3.h>
#import "ModelSql.h"
#import "ModelParse.h"
#import "Comment.h"
#import "RecipeParse.h"
@implementation Model{
    ModelParse* parseModelImpl;
    ModelSql* sqlModelImpl;
    NSString* userEmail;
    NSString* userName;
    NSString* userPwd;
}

static Model* instance = nil;

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "parse.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        return NO;
    }
    else{
      //  NSLog(@"-> connection established!\n");
        return YES;
    }
}

+(Model*)instance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[Model alloc] init];
            
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        sqlModelImpl = [[ModelSql alloc] init];
        parseModelImpl = [[ModelParse alloc] init];
    }
    return self;
}

///////////////Account Metohds
-(void)login:(NSString*)name pwd:(NSString*)pwd block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSError* error=[self login:name pwd:pwd];
        if(!error){
        userName=name;
        userPwd=pwd;
        _user = [self getCurrentUserId];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(error);
        });
    } );
}
-(NSError*)login:(NSString*)name pwd:(NSString*)pwd
{
    userEmail=nil;
    return [parseModelImpl login:name pwd:pwd];
}
-(void)logOut:(void(^)(void))block{
    return [parseModelImpl logOut];
}

-(void)signup:(NSString*)email userName:(NSString*)user pwd:(NSString*)pwd block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSError* error = [self signup:email userName:user pwd:pwd];
        
        if (!error) {
            userEmail=email;
            userName = user;
            userPwd=pwd;
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(error);
        });
    } );
}

-(NSError*)signup:(NSString*)email userName:(NSString*)user pwd:(NSString*)pwd{
    return [parseModelImpl signup:email userName:user pwd:pwd];
}

-(void)resetPassword:(NSString*)email block:(void(^)(bool))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        BOOL result=[parseModelImpl resetPassword:email];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(result);
        });
    } );
}
-(void)setCurrentUserName:(NSString*)user{
    userName=user;
    _user = [self getCurrentUserId];
}

/////////////////
-(void)addRecipeAsynch:(Recipe*)recipe block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue =dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        [parseModelImpl addRecipe:recipe];
     //   [sqlModelImpl addRecipe:recipe];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(YES);
        });
    } );
 
}
-(void)addFavoriteAsynch:(Favorites*)favorite block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue =dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        [parseModelImpl addFavorite:favorite];
    //    [sqlModelImpl addFavorite:favorite];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(YES);
        });
    } );
}
-(void)addCommentAsynch:(Comment*)comment block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue =dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        [parseModelImpl addComment:comment];
     //   [sqlModelImpl addComment:comment];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(YES);
        });
    } );

}
-(void)addFollowAsynch: (Follow*)follow block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue =dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        [parseModelImpl addFollow:follow];
      //    [sqlModelImpl addFollow:follow];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(YES);
        });
    } );
 
}
-(NSString*)getUserName{
    return [parseModelImpl getUserName];
}
-(void)getUserNameAndMail:(void(^)(NSString* name,NSString* mail))block{
    if (!userEmail) {
        userEmail=[parseModelImpl getEmail];
    }
    block(userName,userEmail);
}

-(NSString*)getCurrentUserId{
    return [parseModelImpl getCurrentUserId];
}

-(void)getUserName:(NSString*)user block:(void(^)(NSString* name))block{
    dispatch_queue_t myQueue =dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        NSString* userN=[parseModelImpl getUserName:user];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(userN);
        });
    } );
}

-(void)getFollowRecipesAsynch:(void(^)(NSMutableArray*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSMutableArray* updatedDataRecipes;
        NSMutableArray* updatedData;
       // NSMutableArray* data=(NSMutableArray*)[sqlModelImpl getFollowRecipe:_user];
        NSMutableArray* data=(NSMutableArray*)[sqlModelImpl getFollow:_user];
        NSString* lastUpdate = [sqlModelImpl getFollowLastUpdateDate];
        if (lastUpdate != nil){
            updatedData = (NSMutableArray*)[parseModelImpl getFollowFromDate:lastUpdate];
        }else{
            // [parseModelImpl getRecipes];
            updatedData = (NSMutableArray*)[parseModelImpl getFollow:_user];
        }
        if (updatedData.count > 0) {
            updatedDataRecipes = (NSMutableArray*)[parseModelImpl getRecipes];
            [sqlModelImpl updateRecipes:updatedDataRecipes];
            [sqlModelImpl setRecipesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            
            [sqlModelImpl updateFollow:updatedData];
            [sqlModelImpl setFollowLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
         //   data = (NSMutableArray*)[sqlModelImpl getFollowRecipe:_user];
            data = (NSMutableArray*)[sqlModelImpl getFollow:_user];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    });
}
-(void)getCommentsAsynch:(NSString*)recipeId :(void(^)(NSMutableArray*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSMutableArray* data = (NSMutableArray*)[sqlModelImpl getCommentsRecipe:recipeId];
        NSString* lastUpdate = [sqlModelImpl getCommentsLastUpdateDate];
        NSMutableArray* updatedDataRecipes;
        NSMutableArray* updatedData;
        if (lastUpdate != nil){
            updatedData = (NSMutableArray*)[parseModelImpl getCommentsFromDate:lastUpdate];
        }else{
            updatedData = (NSMutableArray*)[parseModelImpl getComments:recipeId];
        }
        if (updatedData.count > 0) {
            updatedDataRecipes = (NSMutableArray*)[parseModelImpl getRecipes];
            [sqlModelImpl updateRecipes:updatedDataRecipes];
            [sqlModelImpl setRecipesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            [sqlModelImpl updateComments:updatedData];
            [sqlModelImpl setCommentsLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            data = (NSMutableArray*)[sqlModelImpl getCommentsRecipe:recipeId];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    });
}



-(void)getFavoriteRecipesAsynch:(void(^)(NSArray*))block{
    
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
   //   [sqlModelImpl getRecipes];
         NSMutableArray* updatedDataRecipes;
        //get all recipes from parse
       updatedDataRecipes = (NSMutableArray*)[parseModelImpl getRecipes];
        //update all recipes in local db & last date.
        [sqlModelImpl updateRecipes:updatedDataRecipes];
        [sqlModelImpl setRecipesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
        //get favorites recipe /& last update of favorite table.
        NSMutableArray* data=(NSMutableArray*)[sqlModelImpl getFavoriteRecipe:_user];
        NSString* lastFavoriteUpdate = [sqlModelImpl getFavoriteLastUpdateDate];
        
        NSMutableArray* updatedData;
        if (lastFavoriteUpdate != nil){//if there is an updates in favorite table -> get the new data from DB
            updatedData = (NSMutableArray*)[parseModelImpl getFavoriteFromDate:lastFavoriteUpdate];
        }else{//if this is a first acsses to the favorite table
          // [parseModelImpl getRecipes];
            updatedData = (NSMutableArray*)[parseModelImpl getFavorite:_user];
        }
        if (updatedData.count > 0) {//updata local db with with the rest data & time
            [sqlModelImpl updateFavorites:updatedData];
            [sqlModelImpl setFavoritesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            data = (NSMutableArray*)[sqlModelImpl getFavoriteRecipe:_user];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    });
}

-(void)getRecipesCategoryAsynch:(NSString*)category :(void(^)(NSArray*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSMutableArray* data = (NSMutableArray*)[sqlModelImpl getRecipeCategory:category];
        NSString* lastUpdate = [sqlModelImpl getRecipesLastUpdateDate];
        NSMutableArray* updatedData;
        if (lastUpdate != nil){
            updatedData = (NSMutableArray*)[parseModelImpl getRecipesFromDate:lastUpdate];
        }else{
            updatedData = (NSMutableArray*)[parseModelImpl getRecipes];
        }
        if (updatedData.count > 0) {
            [sqlModelImpl updateRecipes:updatedData];
            [sqlModelImpl setRecipesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            data = (NSMutableArray*)[sqlModelImpl getRecipeCategory:category];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    });
}



//Block Asynch implementation
-(void)getMyRecipesAsynch:(NSString*)forSpecificUser withblock:(void(^)(NSMutableArray*))block{
    NSString* choosenUser=nil;
    if(forSpecificUser!=nil)
        choosenUser=forSpecificUser;
    else choosenUser=_user;
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSMutableArray* data = (NSMutableArray*)[sqlModelImpl getMyRecipes:choosenUser];
        NSString* lastUpdate = [sqlModelImpl getRecipesLastUpdateDate];
        NSMutableArray* updatedData;
        if (lastUpdate != nil){
            updatedData = (NSMutableArray*)[parseModelImpl getRecipesFromDate:lastUpdate];
        }else{
            updatedData = (NSMutableArray*)[parseModelImpl getMyRecipes];
        }
        if (updatedData.count > 0) {
            [sqlModelImpl updateRecipes:updatedData];
            [sqlModelImpl setRecipesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            data = (NSMutableArray*)[sqlModelImpl getMyRecipes:choosenUser];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

//////////////////// get image
-(void)getRecipeImage:(Recipe*)r block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        
        //first try to get the image from local file
        UIImage* image = [self readingImageFromFile:r.imageName];
        //if failed to get image from file try to get it from parse
        if(image == nil){
            image =  [parseModelImpl getImage:r.imageName];
            //one the image is loaded save it localy
            if(image != nil){
                [self savingImageToFile:image fileName:r.imageName];
            }
        }

        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    });
}

-(UIImage*)readingImageFromFile:(NSString*)fileName{
    NSData* pngData = [self readFromFile:fileName];
    if (pngData == nil) return nil;
    return [UIImage imageWithData:pngData];
}
-(NSData*)readFromFile:(NSString*)fileName{
    NSString* filePath = [self getLocalFilePath:fileName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    return pngData;
}

-(NSString*)getLocalFilePath:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return filePath;
}
//////////////////// save image
-(void)saveRecipeImage:(Recipe*)r image:(UIImage*)image block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //save the image to parse
        [parseModelImpl saveImage:image withName:r.imageName];
        //save the image localy
        [self savingImageToFile:image fileName:r.imageName];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

// Working with local files
-(void)savingImageToFile:(UIImage*)image fileName:(NSString*)fileName{
    NSData *pngData = UIImagePNGRepresentation(image);
    [self saveToFile:pngData fileName:fileName];
}
-(void)saveToFile:(NSData*)data fileName:(NSString*)fileName{
    NSString* filePath = [self getLocalFilePath:fileName];
    [data writeToFile:filePath atomically:YES]; //Write the file
}

//Block Asynch implementation
-(void)getRecipesAsynch:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    dispatch_async(myQueue, ^{
        //long operation
        NSMutableArray* data = (NSMutableArray*)[sqlModelImpl getRecipes];
        NSString* lastUpdate = [sqlModelImpl getRecipesLastUpdateDate];
        NSMutableArray* updatedData;
        if (lastUpdate != nil){
            updatedData = (NSMutableArray*)[parseModelImpl getRecipesFromDate:lastUpdate];
        }else{
            updatedData = (NSMutableArray*)[parseModelImpl getRecipes];
        }
        if (updatedData.count > 0) {
            [sqlModelImpl updateRecipes:updatedData];
            [sqlModelImpl setRecipesLastUpdateDate:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
            data = (NSMutableArray*)[sqlModelImpl getRecipes];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

@end
