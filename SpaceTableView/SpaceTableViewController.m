//
//  SpaceTableViewController.m
//  
//
//  Created by Vincent Chau on 6/25/15.
//
//

#import "SpaceTableViewController.h"

@interface SpaceTableViewController ()

@end

@implementation SpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark Lazy instatianation of properties
// if planets dont have a variable, return planets after it allocaated
-(NSMutableArray *)planets{
    if(!_planets){
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}
// use '_' in getters for properties
-(NSMutableArray *)addedSpaceObjects{
    if(!_addedSpaceObjects){
        _addedSpaceObjects = [[NSMutableArray alloc] init];
        
    }
    return _addedSpaceObjects;
}

-(id) initWithStyle:(UITableViewStyle) style{
    self = [super initWithStyle:style];
    if(self){
        
    }
    return self;
}

#pragma mark AddObjectViewController Delegate
// will be called from addobjectviewcontroller.m file
-(void)didCancel{
    
    NSLog(@"did cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addSpaceObject:(SpaceObject *)spaceObject{

    
    // lazy instantiationed
    [self.addedSpaceObjects addObject:spaceObject];
    
    // Will Save To NSUserDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    
    if(!spaceObjectsAsPropertyLists)
        spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    // add object to property list
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAtPropertyList:spaceObject]];
     
    // save nsarray to NS user defaults for key
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    
    // save mutable array
    [[NSUserDefaults standardUserDefaults] synchronize]; // save with mutableable array
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData]; //check for new data
}
#pragma mark - Helper Methods
-(NSDictionary *)spaceObjectAtPropertyList:(SpaceObject*)spaceObject{

    NSData *image = UIImagePNGRepresentation(spaceObject.spaceImg);
    NSDictionary *dictionary = @{PLANET_NAME : spaceObject.name,
                                 PLANET_GRAVITY : @(spaceObject.gForce),
                                 PLANET_DIAMETER : @(spaceObject.diameter),
                                 PLANET_YEAR_LENGTH : @(spaceObject.yearLength),
                                 PLANET_TEMPERATURE : @(spaceObject.temperature),
                                 PLANET_NUMBER_OF_MOONS : @(spaceObject.numMoons),
                                 PLANET_NICKNAME : spaceObject.nickname,
                                 PLANET_INTERESTING_FACT : spaceObject.randFact,
                                 PLANET_IMAGE : image};
    return dictionary;
}

-(SpaceObject *)spaceObjectForDictionary:(NSDictionary *) dictionary{
    
    NSData *dataForImage = dictionary[PLANET_IMAGE];

    UIImage *spaceObjectImage = [[UIImage alloc ]initWithData:dataForImage];
    
    SpaceObject *spaceObject = [[SpaceObject alloc] initWithData:dictionary dataImage:spaceObjectImage];
    
    
    return spaceObject;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //self.planets = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        
        NSString *imgName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
    
        SpaceObject *planet = [[SpaceObject alloc] initWithData:planetData dataImage: [UIImage  imageNamed:imgName]];
        
        [self.planets addObject:planet];
    }
    
    
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    
    for(NSDictionary *dictionary in myPlanetsAsPropertyLists){
    
        SpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        
        [self.addedSpaceObjects addObject:spaceObject];
    }

    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // id is pointer to any type of object, sender is object that triggered segue
    
    if([sender isKindOfClass:[UITableViewCell class]]) // type uitableview
    {
        // check if its correct view controller to spacetableviewcontroller
        if([segue.destinationViewController isKindOfClass:[SpaceImageViewController class]])
        {  
            
            SpaceImageViewController *nextViewController = segue.destinationViewController;
            
            // get index path to my cell
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            
            SpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
                
            }else if( path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            // proxy property to pass value to new view controller
            nextViewController.spaceObject = selectedObject;
        }
    }
    
    // accessory button
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if([segue.destinationViewController isKindOfClass:[SpaceDataViewController class]])
        {
            SpaceDataViewController *targetViewController = segue.destinationViewController;
            
            NSIndexPath *path = sender;
            
            SpaceObject *selectedObject;
            if (path.section == 0) {
                
            selectedObject = self.planets[path.row];
                
            }
            else if(path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            targetViewController.spaceObject = selectedObject;
            
            
        }
    }
    
    
    if([segue.destinationViewController isKindOfClass: [AddObjectViewController class]])
    {
        // create instance of add space object class
        AddObjectViewController *addSpaceObject = segue.destinationViewController;
        // set the property of delegate to this current view controller
        addSpaceObject.delegate = self;
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.addedSpaceObjects count]) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        return [self.addedSpaceObjects count];
    }
    else{
        return [self.planets count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        SpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImg;

    }
    else{
        SpaceObject *planet = [ self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImg;

    }
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    tableView.backgroundColor = [UIColor blackColor];
    return cell;
}

#pragma mark UITableView Delegate
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
    
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.

    if (indexPath.section == 1)
        return YES;
    else
        return NO;
    
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newSpaceObjectData = [[NSMutableArray alloc] init];
        for (SpaceObject *spaceObject in self.addedSpaceObjects) {
            
            [newSpaceObjectData addObject:[self spaceObjectAtPropertyList:spaceObject]];
            // now a  list of valid property list
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if(newSpaceObjectData.count > 0){
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
        else{
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            
        }
         } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
