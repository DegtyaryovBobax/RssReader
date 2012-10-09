//
//  FeedsItemViewController.h
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "SitesForRootViewController.h"
#import "WebViewController.h"

@interface FeedsItemViewController : UITableViewController <NSXMLParserDelegate>

{
    //RSS parser)))
    NSXMLParser *_rssParser;
    //  HabraItem *currentItem;
    Article *_currentItem;
    // массив всех статей из ленты
    NSMutableArray *_hItems;
    //название текущего эл-та XML
    NSString *_currentProperty;
    //значение текущего эл-та
    NSMutableString *_currentValue;
    SitesForRootViewController *site;
    //IBOutlet UITableView *table;
    
}

-(void) getDataFromRSS;
-(id) initWithSiteForGetData: (SitesForRootViewController *) siteForGetData;
@end
