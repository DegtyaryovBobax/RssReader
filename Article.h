//
//  Article.h
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSURL *link;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) UIImage *img;
@property (nonatomic, retain) NSDate *pubDate;
@property (nonatomic, retain) NSString *pubDateInString;

-(void) setValue:(NSString*)value forProperty:(NSString *)property;


@end
