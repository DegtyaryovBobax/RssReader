//
//  AppDelegate.m
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@implementation AppDelegate

//- (void)dealloc
//{
//    [_window release];
//    [super dealloc];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]autorelease] ;
    
    RootViewController *rootViewController = [[RootViewController alloc] init];
    
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [rootViewController release];
    self.window.rootViewController =mainNavigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [mainNavigationController release];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
