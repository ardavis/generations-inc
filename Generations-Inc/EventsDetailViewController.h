//
//  EventsDetailViewController.h
//  Generations-Inc
//
//  Created by Andrew Davis on 8/10/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;
@class EventDataController;

@interface EventsDetailViewController : UIViewController

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;

@property (weak, nonatomic) EventDataController *myEvents;
@property (weak, nonatomic) EventDataController *upcomingEvents;
@property (weak, nonatomic) EventDataController *bookmarkedEvents;

@end
