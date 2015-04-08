//
//  MapViewController.h
//  Club
//
//  Created by MartinLi on 15-4-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h" 
@interface MapViewController : UIViewController<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property(nonatomic,strong) NSString *sellername;
@property(nonatomic,strong) NSString *Latitude;
@property(nonatomic,strong) NSString *Longitude;
@end
