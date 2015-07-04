//
//  AddObjectViewController.m
//  SpaceTableView
//
//  Created by Vincent Chau on 6/29/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "AddObjectViewController.h"

@interface AddObjectViewController ()

@end

@implementation AddObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(UIButton *)sender {
   
    [self.delegate didCancel];
    
}

- (IBAction)addButtonPressed:(UIButton *)sender {
    
    SpaceObject *newObj = [self returnNewSpaceObject];
    
    [self.delegate addSpaceObject:newObj];
    
}

-(SpaceObject *)returnNewSpaceObject{
    
    SpaceObject *addedObject = [[SpaceObject alloc ]init];
    addedObject.name = self.nameTextField.text;
    addedObject.nickname = self.nicknameTextField.text;
    addedObject.diameter = [self.diameterTextField.text floatValue];
    addedObject.temperature = [self.temperatureTextField.text floatValue];
    addedObject.numMoons = [self.numberTextField.text intValue];
    addedObject.randFact = self.randFactTextField.text;
    addedObject.spaceImg = [UIImage imageNamed:@"EinsteinRing.jpg"];
    
    return addedObject;
}
@end
