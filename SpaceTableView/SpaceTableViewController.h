//
//  SpaceTableViewController.h
//  
//
//  Created by Vincent Chau on 6/25/15.
//
//

#import <UIKit/UIKit.h>
#import "AstronomicalData.h"
#import "SpaceObject.h"
#import "SpaceImageViewController.h"
#import "SpaceDataViewController.h"
#import "AddObjectViewController.h"

@interface SpaceTableViewController : UITableViewController <AddObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;


@end
