//
//  EventsDetailViewController.h
//  Generations-Inc
//
//  Created by Andrew Davis on 8/10/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol EventsDetailViewControllerDelegate;

@class Event;
@class EventDataController;
@class EventsMasterViewController;

@interface EventsDetailViewController : UIViewController

@property (weak, nonatomic) id <EventsDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)yesClicked:(id)sender;
- (IBAction)noClicked:(id)sender;
- (IBAction)bookmarkClicked:(id)sender;
@end

@protocol EventsDetailViewControllerDelegate <NSObject>
- (void)eventsViewControllerDidCancel:(EventsDetailViewController *)controller event:(Event *)event;
- (void)eventsViewControllerDidRegister:(EventsDetailViewController *)controller name:(NSString *)name location:(NSString *)location desc:(NSString *)desc date:(NSDate *)date;
- (void)eventsViewControllerDidBookmark:(EventsDetailViewController *)controller name:(NSString *)name location:(NSString *)location desc:(NSString *)desc date:(NSDate *)date;
@end
