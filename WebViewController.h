//
//  WebViewController.h
//  RssReader
//
//  Created by Администратор on 10/6/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSURL *urlForView;

- (id)initWithURL:(NSURL *)url;
@end
