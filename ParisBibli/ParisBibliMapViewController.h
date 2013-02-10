//
//  ParisBibliMapViewController.h
//  ParisBibli
//
//  Created by Alexandre Bulté on 01/02/13.
//  Copyright (c) 2013 Bulte.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ParisBibliMapViewController : UIViewController <NSFetchedResultsControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)refreshFeed:(id)sender;
- (IBAction)refreshLocation:(id)sender;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
