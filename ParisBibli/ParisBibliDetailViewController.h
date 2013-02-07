//
//  ParisBibliDetailViewController.h
//  ParisBibli
//
//  Created by Alexandre Bulté on 31/01/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bibliotheque.h"

@interface ParisBibliDetailViewController : UIViewController

@property (strong, nonatomic) Bibliotheque* bibli;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
@property (weak, nonatomic) IBOutlet UIButton *detailGoogleMaps;

- (IBAction)goByFoot:(id)sender;
- (IBAction)openGoogleMaps:(id)sender;
@end
