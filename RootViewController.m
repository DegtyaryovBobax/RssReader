//
//  RootViewController.m
//  RssReader
//
//  Created by Администратор on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "RootViewController.h"
#import "FeedsItemViewController.h"

@interface RootViewController ()
{
    NSMutableArray *arrayOfTitles;
    NSMutableArray *arrayOfURL;
}
@end


@implementation RootViewController
@synthesize arrayOfSites;
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
    
    arrayOfTitles = [[NSUserDefaults standardUserDefaults] objectForKey:@"listOfTitles"];
    arrayOfURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"listOfURL"];
    NSLog(@"%d, %d",[ arrayOfTitles count], [arrayOfURL count]);
    arrayOfSites = [[NSMutableArray alloc] init];
    if (!arrayOfTitles || !arrayOfURL || ![arrayOfURL count] || ![arrayOfTitles count])
    {
        arrayOfTitles = [[NSMutableArray alloc] init];
        arrayOfURL = [[NSMutableArray alloc] init];
        SitesForRootViewController *tempSite = [[SitesForRootViewController alloc] initWithSetPropertiesForURL:@"http://news.google.com/news?cf=all&ned=ru_ru&hl=ru&topic=w&output=rss"    andTitleOfSiteForTableView:@"Гугл: в мире"];    [arrayOfSites addObject: tempSite];
        [arrayOfTitles addObject:@"Гугл: в мире"];
        [arrayOfURL addObject:@"http://news.google.com/news?cf=all&ned=ru_ru&hl=ru&topic=w&output=rss"];
        [tempSite release];
        tempSite = [[SitesForRootViewController alloc] initWithSetPropertiesForURL:@"http://habrahabr.ru/rss"    andTitleOfSiteForTableView:@"Habr"];
        [arrayOfSites addObject:tempSite ];
        
        [arrayOfTitles addObject:@"Habr"];
        [arrayOfURL addObject:@"http://habrahabr.ru/rss"];
        [tempSite release];
        
    }
    else
    {
        for (int i=0; i<[arrayOfTitles count]; i++)
        {
            SitesForRootViewController *tempSite = [[SitesForRootViewController alloc] initWithSetPropertiesForURL:[arrayOfURL objectAtIndex:i]
                                                                                        andTitleOfSiteForTableView:[arrayOfTitles objectAtIndex:i]] ;
            [arrayOfSites addObject: tempSite];
            [tempSite release];
        }
        
    }
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    self.title = @"List of sites";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertFeed)];
    self.navigationItem.leftBarButtonItem = addButton;
    [addButton release];
}
-(void)insertFeed
{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Adding sites: " message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    dialog.message = @"Inser URL of feed";
    dialog.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    UITextField *title = [dialog textFieldAtIndex:0];
    UITextField *urlField = [dialog textFieldAtIndex:1];
    
    title.placeholder =  @"Enter Title";
    title.returnKeyType = UIReturnKeyDone;
    title.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    urlField.text = @"http://";
    urlField.placeholder = @"Enter feed's URL";
    urlField.keyboardType = UIKeyboardTypeURL;
    urlField.returnKeyType = UIReturnKeyDone;
    urlField.secureTextEntry = NO;
    
	[dialog show];
    [dialog release];
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    UITextField *titleField = [alertView textFieldAtIndex:0];
    UITextField *urlField = [alertView textFieldAtIndex:1];
    
    if ([urlField.text length] <= 7 || [titleField.text length] <= 0)
    {
        return NO;
    }
    
    return YES;
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
    {
        UITextField *titleField = [actionSheet textFieldAtIndex:0];
        UITextField *urlField = [actionSheet textFieldAtIndex:1];
        NSString *title = titleField.text;
        NSString *url = urlField.text;
        SitesForRootViewController *tempSite = [[SitesForRootViewController alloc] initWithSetPropertiesForURL:url andTitleOfSiteForTableView:title];
        [arrayOfTitles addObject:title];
        [arrayOfURL addObject:url];
        
        [arrayOfSites addObject:tempSite];
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfTitles forKey:@"listOfTitles"];
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfURL forKey:@"listOfURL"];
        [tempSite release];
        [self.tableView reloadData];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOfSites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]autorelease];
    }
    
    SitesForRootViewController *tempItem = [arrayOfSites objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = tempItem.urlInString ;
    cell.textLabel.text =tempItem.titleOfSiteForTableView;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrayOfSites removeObjectAtIndex:indexPath.row ];
        [arrayOfTitles removeObjectAtIndex:indexPath.row];
        [arrayOfURL removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfTitles forKey:@"listOfTitles"];
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfURL forKey:@"listOfURL"];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [arrayOfSites exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [arrayOfTitles exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [arrayOfURL exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:arrayOfTitles forKey:@"listOfTitles"];
    [[NSUserDefaults standardUserDefaults] setObject:arrayOfURL forKey:@"listOfURL"];
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedsItemViewController *nextController = [[FeedsItemViewController alloc] initWithSiteForGetData:[arrayOfSites objectAtIndex:indexPath.row] ];
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

@end
