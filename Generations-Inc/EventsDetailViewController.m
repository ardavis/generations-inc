//
//  EventsDetailViewController.m
//  Generations-Inc
//
//  Created by Andrew Davis on 8/10/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "Event.h"

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController
@synthesize noButton = _noButton;
@synthesize yesButton = _yesButton;

@synthesize event = _event, locationLabel = _locationLabel, descLabel = _descLabel, dateLabel = _dateLabel;

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
    [self configureView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    self.event = nil;
    [self setYesButton:nil];
    [self setNoButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)setEvent:(Event *) newEvent
{
    if (_event != newEvent) {
        _event = newEvent;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    Event *theEvent = self.event;
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    if (theEvent) {
        self.navigationItem.title = theEvent.name;
        self.locationLabel.text = theEvent.location;
        self.descLabel.text = theEvent.desc;
        self.dateLabel.text = [formatter stringFromDate:(NSDate *)theEvent.date];
        // Set image
        // Set map
        // Set attendees
    }
}

@end
