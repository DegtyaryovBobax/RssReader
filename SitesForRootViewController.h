//
//  SitesForRootViewController.h
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SitesForRootViewController : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSURL * url;
@property (nonatomic, retain) NSString *titleOfSiteForTableView;
@property (nonatomic, retain) NSString *urlInString;
-(id) initWithSetPropertiesForURL: (NSString*) link andTitleOfSiteForTableView:(NSString*)titleOfSite;
@end
