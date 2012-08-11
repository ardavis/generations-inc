//
//  EventsDetailViewController.m
//  Generations-Inc
//
//  Created by Andrew Davis on 8/10/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "EventsMasterViewController.h"
#import "Event.h"
#import <QuartzCore/CALayer.h>

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController
@synthesize noButton = _noButton;
@synthesize yesButton = _yesButton;
@synthesize bookmarkButton = _bookmarkButton;
@synthesize mapView = _mapView;
@synthesize imageView = _imageView;
@synthesize delegate = _delegate;
@synthesize nameLabel = _nameLabel;

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
    [self setMapView:nil];
    [self setImageView:nil];
    [self setNameLabel:nil];
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
        [formatter setDateStyle:NSDateFormatterLongStyle];
    }
    if (theEvent) {
        // Place event information
        self.nameLabel.text = theEvent.name;
        self.locationLabel.text = theEvent.location;
        self.descLabel.text = theEvent.desc;
        self.dateLabel.text = [formatter stringFromDate:(NSDate *)theEvent.date];
        
        //Add borders
        self.nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
        self.nameLabel.layer.borderWidth = 1.0;
        self.nameLabel.layer.cornerRadius = 8;
        
        // If no description, say "No Description Provided"
        if (self.descLabel.text == @"")
            self.descLabel.text = @"No Description Provided.";
        
        if (self.locationLabel.text == @"")
            self.locationLabel.text = @"No Location Provided.";
        
        if (self.dateLabel.text = @"")
            self.dateLabel.text = @"No Date Provided.";
        
        // Set image
        
        // Set map
        
        // Set attendees
    }
}

- (IBAction)yesClicked:(id)sender {
    Event *theEvent = self.event;
    [[self delegate] eventsViewControllerDidRegister:self name:theEvent.name location:theEvent.location desc:theEvent.desc date:theEvent.date];
}

- (IBAction)noClicked:(id)sender {
    Event *theEvent = self.event;
    [[self delegate] eventsViewControllerDidCancel:self event:theEvent];
}

- (IBAction)bookmarkClicked:(id)sender {
    Event *theEvent = self.event;
    [[self delegate] eventsViewControllerDidBookmark:self name:theEvent.name location:theEvent.location desc:theEvent.desc date:theEvent.date];
}

@end
