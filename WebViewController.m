//
//  WebViewController.m
//  RssReader
//
//  Created by Администратор on 10/6/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;


- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self != nil)
    {
        _urlForView = [url retain];
    }
    return self;
}
- (void)viewDidUnload
{
    //  [self setWebView:nil];
    [super viewDidUnload];
}
-(void)dealloc
{
    self.webView.delegate = nil;
    [_urlForView release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"News";
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:_urlForView];
    webView= [[UIWebView alloc]init];
    self.webView.delegate = self;
    self.view = webView;
    [webView loadRequest:urlRequest];
    [webView setScalesPageToFit:YES];
}


@end
