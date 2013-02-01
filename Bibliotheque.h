//
//  Bibliotheque.h
//  ParisBibli
//
//  Created by Alexandre Bulté on 31/01/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>


@interface Bibliotheque : NSManagedObject

@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSString * nomCourt;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * codePostal;
@property (nonatomic, retain) NSString * complementVoie;
@property (nonatomic, retain) NSString * numeroVoie;
@property (nonatomic, retain) NSString * nomVoie;

@end
