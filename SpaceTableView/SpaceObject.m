//
//  SpaceObject.m
//  SpaceTableView
//
//  Created by Vincent Chau on 6/25/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "SpaceObject.h"


@implementation SpaceObject

-(id)init{
    self = [self initWithData:nil dataImage:nil];
    return self;
}

-(id)initWithData:(NSDictionary*)data
        dataImage:(UIImage*) image{
    
    self = [super init];
    
    self.name = data[PLANET_NAME];
    self.gForce = [data[PLANET_GRAVITY] floatValue];
    self.diameter = [data[PLANET_DIAMETER] floatValue];
    self.yearLength = [data[PLANET_YEAR_LENGTH] floatValue];
    self.dayLength = [data[PLANET_YEAR_LENGTH] floatValue];
    self.temperature = [data[PLANET_TEMPERATURE] floatValue];
    self.numMoons = [data[PLANET_NUMBER_OF_MOONS] intValue];
    self.nickname = data[PLANET_NICKNAME];
    self.randFact = data[PLANET_INTERESTING_FACT];
    
    self.spaceImg = image;
    
    
    
    return self;
}



@end

