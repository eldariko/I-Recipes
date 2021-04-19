//
//  Comment.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "Comment.h"

@implementation Comment

//initialize the comment information
-(id)init:(NSString*)recipeId comment:(NSString*)comment userId:(NSString*)userId{
    self = [super init];
    if (self){
        _recipeId = recipeId;
        _comment=comment;
        _userId=userId;
    }
    return self;
}
@end
