//
//  CategoryRecipesNavigation.m
//  Recipes
//
//  Created by Lital Zigron on 12/30/15.
//  Copyright © 2015 Lital Zigron. All rights reserved.
//

#import "CategoryRecipesNavigation.h"

@interface CategoryRecipesNavigation ()

@end

@implementation CategoryRecipesNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSLog(@"%@",self.category);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
