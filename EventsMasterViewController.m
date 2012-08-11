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

@interface EventsMasterViewController() <EventsDetailViewControllerDelegate>
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
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [self.upcomingEventsDataController addEventWithName:@"Crafternoon" location:@"Dudley Sq. Lib." desc:@"" date:[dateFormatter dateFromString:@"08-01-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Computer Help" location:@"Kingston St." desc:@"" date:[dateFormatter dateFromString:@"08-01-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Disco Night" location:@"City Hall Plaza" desc:@"" date:[dateFormatter dateFromString:@"08-01-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Marilyn Monroe Lecture" location:@"BPL-Copley" desc:@"" date:[dateFormatter dateFromString:@"08-02-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Walking Club" location:@"Franklin Park" desc:@"" date:[dateFormatter dateFromString:@"08-03-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Museum of Fine Arts Visit" location:@"" desc:@"" date:[dateFormatter dateFromString:@"08-03-2012"]];
    [self.upcomingEventsDataController addEventWithName:@"Boston Urban Musical Festival" location:@"City Hall Plaza" desc:@"" date:[dateFormatter dateFromString:@"08-04-2012"]];
    
    //[self.myEventsDataController addEventWithName:@"Batman" location:@"Your Mom" desc:@"Your Mom again..." date:[dateFormatter dateFromString:@"12-31-2012"]];
    //[self.myEventsDataController addEventWithName:@"Superman" location:@"Your Mom" desc:@"Your Mom again..." date:[dateFormatter dateFromString:@"12-31-2012"]];
    
    //[self.bookmarkedEventsDataController addEventWithName:@"Spiderman!" location:@"Book" desc:@"Awesome Book right?" date:[dateFormatter dateFromString:@"01-10-1991"]];
    
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
    EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (!cell)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[EventCell class]])
            {
                cell = (EventCell *)currentObject;
                break;
            }
        }
    }
    
    switch (self.currentDataController) {
        case MY_EVENTS:
            myEvent = [self.myEventsDataController objectInListAtIndex:indexPath.row];
            break;
        case UPCOMING_EVENTS:
            myEvent = [self.upcomingEventsDataController objectInListAtIndex:indexPath.row];
            break;
        case BOOKMARKED_EVENTS:
            myEvent = [self.bookmarkedEventsDataController objectInListAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    // Set up the cell
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    cell.titleLabel.text = myEvent.name;
    cell.locationLabel.text = myEvent.location;
    cell.dateLabel.text = [dateFormatter stringFromDate:myEvent.date];
    cell.typeLabel.text = @"Social";
    
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
        
        detailViewController.delegate = self;
    }
}

- (IBAction)segmentSelected:(UISegmentedControl *)sender {
    // Update the currentDataController
    self.currentDataController = [sender selectedSegmentIndex];
    [self.eventsTableView reloadData];
}

- (void)eventsViewControllerDidCancel:(EventsDetailViewController *)controller event:(Event *)event {
    [self.myEventsDataController removeEvent:event];
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.currentDataController = UPCOMING_EVENTS;
    [self.navControl setSelectedSegmentIndex:UPCOMING_EVENTS];
    [self.eventsTableView reloadData];
    [self.eventsTableView reloadData];
}

- (void)eventsViewControllerDidRegister:(EventsDetailViewController *)controller name:(NSString *)name location:(NSString *)location desc:(NSString *)desc date:(NSDate *)date {
    
    [self.myEventsDataController addEventWithName:name location:location desc:desc date:date];
    [self.navControl setSelectedSegmentIndex:MY_EVENTS];
    self.currentDataController = MY_EVENTS;
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.eventsTableView reloadData];
    [self.eventsTableView reloadData];
}

- (void)eventsViewControllerDidBookmark:(EventsDetailViewController *)controller name:(NSString *)name location:(NSString *)location desc:(NSString *)desc date:(NSDate *)date {
    [self.bookmarkedEventsDataController addEventWithName:name location:location desc:desc date:date];
    [self.navControl setSelectedSegmentIndex:BOOKMARKED_EVENTS];
    self.currentDataController = BOOKMARKED_EVENTS;
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.eventsTableView reloadData];
    [self.eventsTableView reloadData];
}

@end



















