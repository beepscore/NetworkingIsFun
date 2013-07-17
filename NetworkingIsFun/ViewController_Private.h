//
//  ViewController.h
//  NetworkingIsFun
//
//  Created by Steve Baker on 7/16/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//
//  Expose methods for use by unit tests

#import "ViewController.h"

@interface ViewController ()

- (void)configureActivityIndicator;

// makes a web request to url
// if successful, assigns JSON "results" to self.movies
// if failure, logs error
- (void)requestMoviesURL:(NSURL *)url;

@end
