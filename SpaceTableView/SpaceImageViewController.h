//
//  SpaceImageViewController.h
//  SpaceTableView
//
//  Created by Vincent Chau on 6/25/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AstronomicalData.h"
#import "SpaceObject.h"
#import "SpaceTableViewController.h"
@interface SpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) SpaceObject *spaceObject;

@end
