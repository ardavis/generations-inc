//
//  NewsfeedViewController.m
//  Generations-Inc
//
//  Created by Andrew Davis on 8/8/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import "NewsfeedViewController.h"

@interface NewsfeedViewController ()

@end

@implementation NewsfeedViewController
@synthesize newsfeedWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *urlAddress = @"http://generationsinc.org/blog";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [newsfeedWebView loadRequest:requestObj];
	
}

- (void)viewDidUnload
{
    [self setNewsfeedWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
