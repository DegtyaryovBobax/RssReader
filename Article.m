//
//  Article.m
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "Article.h"

@implementation Article


-(void)setValue:(NSString *)value forProperty:(NSString *)property
{
    if ([property isEqualToString:@"link"]) {
        
        _link = [[NSURL URLWithString:value] retain];
        
        return;
        
        
        
    } else if ([property isEqualToString:@"pubDate"])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
        _pubDate = [dateFormat dateFromString:value];
        _pubDateInString = value;
        [dateFormat release];
        
        [_pubDate retain];
        [_pubDateInString retain];
        return;
        
    }
    [self setValue:value forKey:property ];
    
}


@end
