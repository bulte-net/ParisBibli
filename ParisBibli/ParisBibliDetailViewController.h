//
//  ParisBibliDetailViewController.h
//  ParisBibli
//
//  Created by Alexandre Bulté on 31/01/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParisBibliDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
