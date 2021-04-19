//
//  Follow.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Follow : NSObject
@property NSString* follower;
@property NSString* beingFollowed;

//initialize the follow information
-(id)init:(NSString*)follower beingFollowed:(NSString*)beingFollowed;
@end
