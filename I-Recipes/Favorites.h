//
//  Favorites.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Favorites : NSObject

@property NSString* recipeId;
@property NSString* user;

//initialize the favorite recipe information
-(id)init:(NSString*)recipeId user:(NSString*)user;

@end
