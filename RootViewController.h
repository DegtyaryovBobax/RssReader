//
//  RootViewController.h
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SitesForRootViewController.h"
@interface RootViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *arrayOfSites;
@end
