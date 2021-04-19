//
//  Follow.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "Follow.h"

@implementation Follow

//initialize the follow information
-(id)init:(NSString*)follower beingFollowed:(NSString*)beingFollowed{
    self = [super init];
    if (self){
        _follower = follower;
        _beingFollowed=beingFollowed;
    }
    return self;
}
@end
