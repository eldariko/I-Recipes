//
//  Follow&FavoriteViewController.h
//  Recipes
//
//  This controller presents in separated tabs the current user's favorite recipes and users he\she follows.
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 28/12/15.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Follow&favoriteTableViewCell.h"
#import "Recipe.h"
#import "Model.h"
#import "CheckInternet.h"
@interface Follow_FavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentChange:(UISegmentedControl *)sender;

@end
