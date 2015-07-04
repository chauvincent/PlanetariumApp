//
//  AddObjectViewController.h
//  SpaceTableView
//
//  Created by Vincent Chau on 6/29/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceObject.h"
@protocol AddObjectViewControllerDelegate <NSObject>

@required

-(void)addSpaceObject:(SpaceObject *)spaceObject; // implemented in table view controller file
-(void)didCancel;

@end

@interface AddObjectViewController : UIViewController
// weak to avoid retaining cycles, need to allocate
@property (weak,nonatomic) id <AddObjectViewControllerDelegate> delegate; // conform

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) IBOutlet UITextField *randFactTextField;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;

@end
