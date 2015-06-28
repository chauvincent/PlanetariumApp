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


-(id) initWithStyle:(UITableViewStyle) style{
    self = [super initWithStyle:style];
    if(self){
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.planets = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        
        NSString *imgName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
    
        SpaceObject *planet = [[SpaceObject alloc] initWithData:planetData dataImage: [UIImage  imageNamed:imgName]];
        
        [self.planets addObject:planet];
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
            
            SpaceObject *selectedObject = self.planets[path.row];
            
            // proxy property to pass value to new view controller
            nextViewController.spaceObject = selectedObject;
        }
    }
    
    
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if([segue.destinationViewController isKindOfClass:[SpaceDataViewController class]])
        {
            SpaceDataViewController *targetViewController = segue.destinationViewController;
            
            NSIndexPath *path = sender;
            
            SpaceObject *selectedObject = self.planets[path.row];
            
            targetViewController.spaceObject = selectedObject;
            
            
        }
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.planets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    SpaceObject *planet = [ self.planets objectAtIndex:indexPath.row];
    cell.textLabel.text = planet.name;
    cell.detailTextLabel.text = planet.nickname;
    cell.imageView.image = planet.spaceImg;
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
