//
//  ParisBibliDetailViewController.m
//  ParisBibli
//
//  Created by Alexandre Bulté on 31/01/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import "ParisBibliDetailViewController.h"
#import "ParisBibliInfoViewController.h"
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
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            self.detailGoogleMaps.hidden = false;
        }
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

- (IBAction)openGoogleMaps:(id)sender {
    NSMutableString *address = [NSMutableString stringWithString:self.bibli.address];
    [address replaceOccurrencesOfString:@" " withString:@"+" options:0 range: NSMakeRange(0, [address length])];
    NSString *mapsurl = [NSString stringWithFormat:@"comgooglemaps://?center=%f,%f&zoom=14&q=%@", [self.bibli.latitude doubleValue], [self.bibli.longitude doubleValue], address];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mapsurl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
