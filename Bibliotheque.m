//
//  Bibliotheque.m
//  ParisBibli
//
//  Created by Alexandre Bulté on 31/01/13.
//  Copyright (c) 2013 Bulté.net. All rights reserved.
//

#import "Bibliotheque.h"
#import <AddressBook/AddressBook.h>

@interface Bibliotheque ()

@end


@implementation Bibliotheque

@dynamic nom;
@dynamic nomCourt;
@dynamic latitude;
@dynamic longitude;
@dynamic codePostal;
@dynamic complementVoie;
@dynamic numeroVoie;
@dynamic nomVoie;


- (NSString *)title
{
    return self.nom;
}

- (NSString *)subtitle
{
    NSString *complement;
    if (self.complementVoie){
        complement = self.complementVoie;
    }
    else{
        complement = @"";
    }
	return [NSString stringWithFormat:@"%@%@ %@ %@", self.numeroVoie, complement, self.nomVoie, self.codePostal];
}

- (NSString *)address
{
	return [NSString stringWithFormat:@"%@ %@", self.subtitle, @"Paris"];
}

- (CLLocationCoordinate2D)coordinate
{
	CLLocationCoordinate2D coordinateOnMap;
	coordinateOnMap.latitude = [self.latitude doubleValue];
	coordinateOnMap.longitude = [self.longitude doubleValue];
	
	return coordinateOnMap;
}

- (MKMapItem*)mapItem
{
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey: self.address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end
