//
//  FeedsItemViewController.m
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "FeedsItemViewController.h"
@interface FeedsItemViewController ()

@end

@implementation FeedsItemViewController

-(void) getDataFromRSS
{
    _rssParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:site.urlInString	]];
    [_rssParser setDelegate:self];
    [_rssParser parse];
    
}
-(id) initWithSiteForGetData: (SitesForRootViewController *) siteForGetData
{
    self = [self init];
    site = siteForGetData;
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.title = @"List of Feeds";
    _hItems = [[NSMutableArray alloc] init];
    [self getDataFromRSS];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_hItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"]autorelease];
    cell.detailTextLabel.text = [[_hItems objectAtIndex:indexPath.row] pubDateInString];
    cell.textLabel.text = [[_hItems objectAtIndex:indexPath.row] title];
    return cell;
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *tempURL = [[_hItems objectAtIndex:indexPath.row] link];
    WebViewController *webController = [[WebViewController alloc] initWithURL:tempURL];
    [self.navigationController pushViewController:webController animated:YES];
    [webController release];
}
#pragma mark - NSXML
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // NSLog(@"%@",elementName);
    if ([elementName isEqualToString: @"item"]){
        
        [_currentItem = [Article alloc]init];
        return;
    }else if ([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"link"] || [elementName isEqualToString:@"description"] || [elementName isEqualToString:@"pubDate"]) {
        _currentProperty = elementName;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!_currentValue)
    {
        _currentValue =[[NSMutableString alloc]initWithCapacity:50];
    }
    
    [_currentValue appendString:string];
    
    NSString *trimmedString = [_currentValue stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\t\n"]];
    
    [_currentValue setString:trimmedString];
    
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

{
    if ([elementName isEqualToString:@"item"])
    {
        
        [_hItems addObject:_currentItem];
        //  NSLog(@"Кол-во фидов: %d", [_hItems count]);
        [_currentItem release];
        
        return;
        
    }
    else if ([elementName isEqualToString:_currentProperty])
    {
        
        [_currentItem setValue:_currentValue forProperty:_currentProperty];
        
    }
    
    
    [_currentValue release];
    
    _currentValue = nil;
}

@end
