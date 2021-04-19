//
//  CommentParse.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "CommentParse.h"
#import <Parse/Parse.h>
#import "Comment.h"
@implementation CommentParse
-(NSString*)getCurrentUserId{
    PFUser *currentUser = [PFUser currentUser];
    return currentUser.objectId;
}
//add a new comment to a recipe and save this comment in Parse
-(void)addComment:(Comment*)comment{
    PFObject* obj = [PFObject objectWithClassName:@"Comments"];
    // Recipe image
    obj[@"recipeId"] = comment.recipeId;
    obj[@"user"] = comment.userId;
    obj[@"comment"] = comment.comment;
    [obj save];
}
//get all the comments to the received recipe from Parse
-(NSMutableArray*)getComments:(NSString*)recipeId{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    [query whereKey:@"recipeId" equalTo:recipeId];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Comment* comment = [[Comment alloc] init:obj[@"recipeId"] comment:obj[@"comment"] userId:obj[@"user"]];
        [array addObject:comment];
    }
    return array;
}
//get all the comments that were saved in Parse from a certain data (latest SQL update in Ephoc time)
-(NSArray*)getCommentsFromDate:(NSString *)date{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    NSDate* dated = [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
    [query whereKey:@"updatedAt" greaterThanOrEqualTo:dated];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Comment* comment = [[Comment alloc] init:obj[@"recipeId"] comment:obj[@"comment"] userId:obj[@"user"]];
        [array addObject:comment];
    }
    return array;
}

@end
