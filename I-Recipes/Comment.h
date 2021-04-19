//
//  Comment.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property NSString* recipeId;
@property NSString* comment;
@property NSString* userId;

//initialize the comment information
-(id)init:(NSString*)recipeId comment:(NSString*)comment userId:(NSString*)userId;
@end
