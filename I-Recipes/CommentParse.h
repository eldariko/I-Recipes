//
//  CommentParse.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
@interface CommentParse : NSObject
-(void)addComment:(Comment*)comment; //add a new comment to a recipe and save this comment in Parse
-(NSMutableArray*)getComments:(NSString*)recipeId; //get all the comments to the received recipe from Parse
-(NSArray*)getCommentsFromDate:(NSString *)date; //get all the comments that were saved in Parse from a certain data (latest SQL update in Ephoc time)
@end
