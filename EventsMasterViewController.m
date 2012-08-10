//
//  EventsMasterViewController.m
//  Generations-Inc
//
//  Created by Andrew Davis on 8/9/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import "EventsMasterViewController.h"
#import "EventsDetailViewController.h"
#import "EventDataController.h"
#import "Event.h"
#import "Constants.h"

@interface EventsMasterViewController()
@property (nonatomic) NSInteger currentDataController;
@end

@implementation EventsMasterViewController

@synthesize eventsTableView = _eventsTableView;
@synthesize navControl = _navControl;
@synthesize myEventsDataController = _myEventsDataController;
@synthesize upcomingEventsDataController = _upcomingEventsDataController;
@synthesize bookmarkedEventsDataController = _bookmarkedEventsDataController;
@synthesize currentDataController = _currentDataController;

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
    self.currentDataController = MY_EVENTS;
    
    // This should be in the AppDelegate I think...
    EventDataController *myEventsDataController = [[EventDataController alloc] init];
    self.myEventsDataController = myEventsDataController;
    
    EventDataController *upcomingEventsDataController = [[EventDataController alloc] init];
    self.upcomingEventsDataController = upcomingEventsDataController;
    
    EventDataController *bookmarkedEventsDataController = [[EventDataController alloc] init];
    self.bookmarkedEventsDataController = bookmarkedEventsDataController;
    
    // Pull new events from Google Calendar
    
    // Get the current data controller from the filter selected
    // This will set the "currentDataController" for use to determine which events are shown
    [self segmentSelected:self.navControl];
    
    
    // Sample Data
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    [self.upcomingEventsDataController addEventWithName:@"Coffee Club" location:@"Your House" desc:@"Drink Coffee all day long!!!" date:[dateFormatter dateFromString:@"01-02-2012 08:22"]];
    [self.upcomingEventsDataController addEventWithName:@"Walking Club" location:@"The park" desc:@"Let's walk until we can't!" date:[dateFormatter dateFromString:@"08-11-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Reading Club" location:@"Library" desc:@"Tolkien day!" date:[dateFormatter dateFromString:@"09-30-2012"]];
    
    [self.myEventsDataController addEventWithName:@"Batman" location:@"Your Mom" desc:@"Your Mom again..." date:[dateFormatter dateFromString:@"12-31-2012"]];
    [self.myEventsDataController addEventWithName:@"Superman" location:@"Your Mom" desc:@"Your Mom again..." date:[dateFormatter dateFromString:@"12-31-2012"]];
    
    [self.bookmarkedEventsDataController addEventWithName:@"Spiderman!" location:@"Book" desc:@"Awesome Book right?" date:[dateFormatter dateFromString:@"01-10-1991"]];
    
}

- (void)viewDidUnload
{
    [self setEventsTableView:nil];
    [self setNavControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.currentDataController) {
        case MY_EVENTS:
            return [self.myEventsDataController countOfList];
        case UPCOMING_EVENTS:
            return [self.upcomingEventsDataController countOfList];
        case BOOKMARKED_EVENTS:
            return [self.bookmarkedEventsDataController countOfList];
        default:
            NSLog(@"Error in numberOfRowsInSection");
            return 0;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

#pragma mark UITableViewDataSource

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *myEvent;
    NSString *CellIdentifier = @"EventCell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	// Set up the cell
    switch (self.currentDataController) {
        case MY_EVENTS:
            //NSLog(@"My Events: %d", [self.myEventsDataController countOfList]);
            myEvent = [self.myEventsDataController objectInListAtIndex:indexPath.row];
            break;
        case UPCOMING_EVENTS:
            //NSLog(@"Upcoming Events: %d", [self.upcomingEventsDataController countOfList]);
            myEvent = [self.upcomingEventsDataController objectInListAtIndex:indexPath.row];
            break;
        case BOOKMARKED_EVENTS:
            //NSLog(@"Bookmarked Events: %d", [self.bookmarkedEventsDataController countOfList]);
            myEvent = [self.bookmarkedEventsDataController objectInListAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = myEvent.name;
    cell.detailTextLabel.text = myEvent.location;
    
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowEventDetails"]) {
        EventsDetailViewController *detailViewController = [segue destinationViewController];
        
        switch (self.currentDataController) {
            case MY_EVENTS:
                detailViewController.event = [self.myEventsDataController objectInListAtIndex:[self.eventsTableView indexPathForSelectedRow].row];
                break;
            case UPCOMING_EVENTS:
                detailViewController.event = [self.upcomingEventsDataController objectInListAtIndex:[self.eventsTableView indexPathForSelectedRow].row];
                break;
            case BOOKMARKED_EVENTS:
                detailViewController.event = [self.bookmarkedEventsDataController objectInListAtIndex:[self.eventsTableView indexPathForSelectedRow].row];
                break;
            default:
                break;
        }
    }
}

- (IBAction)segmentSelected:(UISegmentedControl *)sender {
    // Update the currentDataController
    self.currentDataController = [sender selectedSegmentIndex];
    [self.eventsTableView reloadData];
}

@end



















