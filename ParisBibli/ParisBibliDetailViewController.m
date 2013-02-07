//
//  ParisBibliDetailViewController.m
//  ParisBibli
//
//  Created by Alexandre Bulté on 31/01/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import "ParisBibliDetailViewController.h"
#import "Bibliotheque.h"
#import "TestFlight.h"

@interface ParisBibliDetailViewController ()
- (void)configureView;
@end

@implementation ParisBibliDetailViewController

@synthesize bibli = _bibli;

#pragma mark - Managing the detail item

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.bibli) {
        self.detailDescriptionLabel.text = self.bibli.nom;
        self.title = self.bibli.nom;
        self.detailAddress.text = self.bibli.address;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (IBAction)goByFoot:(id)sender {
     NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
     [self.bibli.mapItem openInMapsWithLaunchOptions:launchOptions];
}

- (IBAction)provideFeedback:(id)sender {
    [TestFlight openFeedbackView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
