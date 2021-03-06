//
//  ViewController.m
//  NetworkingIsFun
//
//  Created by Steve Baker on 9/23/12.
//  Copyright (c) 2012 Beepscore LLC. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_Private.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set Up Table View
    self.tableView = [[UITableView alloc]
                      initWithFrame:CGRectMake(0.0,
                                               0.0,
                                               self.view.bounds.size.width,
                                               self.view.bounds.size.height)
                      style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    // Set Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    [self configureActivityIndicator];
    
    // Initialize Data Source
    self.movies = [[NSArray alloc] init];
    
    NSURL *url = [[NSURL alloc]
                  initWithString:@"http://itunes.apple.com/search?term=harry&country=us&entity=movie"];
    [self requestMoviesURL:url];
}

- (void)configureActivityIndicator
{
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
}

- (void)requestMoviesURL:(NSURL *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             //NSLog(@"%@", JSON);
                                             self.movies = [JSON objectForKey:@"results"];
                                             [self.activityIndicatorView stopAnimating];
                                             [self.tableView setHidden:NO];
                                             [self.tableView reloadData];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                         }];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movies && self.movies.count) {
        return self.movies.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Cell Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
    }
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    cell.textLabel.text = [movie objectForKey:@"trackName"];
    cell.detailTextLabel.text = [movie objectForKey:@"artistName"];

    // show thumbnail image
    NSURL *url = [[NSURL alloc] initWithString:[movie objectForKey:@"artworkUrl100"]];
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

#pragma mark - TableView Delegate
//don't implement any delegate methods

#pragma mark -

@end
