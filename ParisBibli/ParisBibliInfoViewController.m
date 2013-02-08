//
//  ParisBibliInfoViewController.m
//  ParisBibli
//
//  Created by Alexandre Bulté on 07/02/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import "ParisBibliInfoViewController.h"
#import "ParisBibliDetailViewController.h"
#import "Bibliotheque.h"

@interface ParisBibliInfoViewController ()

@end

@implementation ParisBibliInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Go back to previous view
- (IBAction)returnToDetail:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
