//
//  SitesForRootViewController.m
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "SitesForRootViewController.h"

@implementation SitesForRootViewController

-(id)initWithSetPropertiesForURL:(NSString *)link andTitleOfSiteForTableView:(NSString *)titleOfSite

{
    self = [self init];
    _url =[[NSURL alloc] initWithString:link];
    _urlInString = [link retain];
    _titleOfSiteForTableView = [titleOfSite retain];
    return self;
}

@end
