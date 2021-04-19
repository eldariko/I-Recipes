//
//  Favorites.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.//
//

#import "Favorites.h"

@implementation Favorites
//initialize the favorite recipe information
-(id)init:(NSString*)recipeId user:(NSString*)user{
    self = [super init];
    if (self){
        _recipeId = recipeId;
        _user=user;
    }
    return self;
}
@end
