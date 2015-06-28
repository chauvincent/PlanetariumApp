//
//  SpaceObject.h
//  SpaceTableView
//
//  Created by Vincent Chau on 6/25/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AstronomicalData.h"
@interface SpaceObject : NSObject


@property (strong, nonatomic) NSString *name;
@property (nonatomic) float gForce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numMoons;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *randFact;

@property (strong, nonatomic) UIImage *spaceImg;

-(id)initWithData:(NSDictionary*)data dataImage:(UIImage*) image;
@end
