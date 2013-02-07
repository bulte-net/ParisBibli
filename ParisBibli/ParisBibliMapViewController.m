//
//  ParisBibliMapViewController.m
//  ParisBibli
//
//  Created by Alexandre Bulté on 01/02/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import "ParisBibliMapViewController.h"
#import "ParisBibliDetailViewController.h"
#import "Bibliotheque.h"
#import "TestFlight.h"

static void ParisBibliShowAlertWithError(NSError *error)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@interface ParisBibliMapViewController ()

@end

@implementation ParisBibliMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set debug logging level. Set to 'RKLogLevelTrace' to see JSON payload
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    
    // Setup View and Table View
    self.title = @"Carte - ParisBibli";
    
    MKUserTrackingBarButtonItem *buttonItem =[[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [self loadData];
}

- (void)loadData
{
    // Useful ?
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    // Load the object model via RestKit
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/bibliotheques/bibliotheques.json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [[NSUserDefaults standardUserDefaults] synchronize];
//        RKManagedObjectStore *managedObjectStore = [RKObjectManager.sharedManager managedObjectStore];
        [self drawLocations];
        RKLogInfo(@"Load complete.");
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Load failed with error: %@", error);
        ParisBibliShowAlertWithError(error);
    }];
}

- (void)drawLocations
{
    // Empty map
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    // trigger fetch (local) and place points
    for (Bibliotheque *bibli in self.fetchedResultsController.fetchedObjects) {
        [_mapView addAnnotation:bibli];
    }    
}

// initial position
- (void)viewWillAppear:(BOOL)animated
{
}

// user position updated
- (void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D userCoordinate = userLocation.location.coordinate;
    [self moveToLocation:userCoordinate];
}

- (void)moveToLocation:(CLLocationCoordinate2D)location {
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    [_mapView setRegion:viewRegion animated:YES];
}

// Button refresh
- (IBAction)refreshFeed:(id)sender {
    [self loadData];
}

// View for each pin
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if (annotation == mapView.userLocation) { //returning nil means 'use built in location view'
		return nil;
	}
	
	MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Bibliotheque"];
    
	if (pinAnnotation == nil) {
		pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Bibliotheque"];
	} else {
		pinAnnotation.annotation = annotation;
	}
	
    pinAnnotation.canShowCallout = YES;
	pinAnnotation.pinColor = MKPinAnnotationColorRed;
	pinAnnotation.animatesDrop = YES;
	
    pinAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
	return pinAnnotation;
}

// Called when detail is asked
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    Bibliotheque *location = (Bibliotheque*)view.annotation;
    [self performSegueWithIdentifier:@"showMapDetail" sender:location];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMapDetail"]) {
        ParisBibliDetailViewController *destViewController = segue.destinationViewController;
        destViewController.bibli = (Bibliotheque *)sender;
    }
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bibliotheque" inManagedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"codePostal" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        ParisBibliShowAlertWithError(error);
	}
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self drawLocations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
