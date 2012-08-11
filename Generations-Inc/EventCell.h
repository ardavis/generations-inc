//
//  EventCell.h
//  Generations-Inc
//
//  Created by Andrew Davis on 8/11/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@propergty (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@end
