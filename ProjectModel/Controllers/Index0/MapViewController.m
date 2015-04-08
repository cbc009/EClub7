//
//  MapViewController.m
//  Club
//
//  Created by MartinLi on 15-4-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<UIGestureRecognizerDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = YES;
    }
//    [self addCustomGestures];//添加自定义的手势
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = [self.Latitude floatValue];
    coor.longitude = [self.Longitude floatValue];
    annotation.coordinate = coor;
    annotation.title = self.sellername;
     NSLog(@"longitude:%@latitude:%@",self.Latitude,self.Longitude);
//    annotation.title = @"这里是北京";
    BMKCoordinateRegion region;
    region.center.latitude = [self.Latitude floatValue];
    region.center.longitude = [self.Longitude floatValue];
    region.span.latitudeDelta = 0.35;
    region.span.longitudeDelta = 0.35;
    _mapView.region = region;
    _mapView.zoomLevel=19;
    [_mapView addAnnotation:annotation];
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}


- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}
//- (void)addCustomGestures {
//    /*
//     *注意：
//     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
//     *否则影响地图内部的手势处理
//     */
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    doubleTap.delegate = self;
//    doubleTap.numberOfTapsRequired = 2;
//    doubleTap.cancelsTouchesInView = NO;
//    doubleTap.delaysTouchesEnded = NO;
//    
//    [self.view addGestureRecognizer:doubleTap];
//    
//    /*
//     *注意：
//     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
//     *否则影响地图内部的手势处理
//     */
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    singleTap.delegate = self;
//    singleTap.cancelsTouchesInView = NO;
//    singleTap.delaysTouchesEnded = NO;
//    [singleTap requireGestureRecognizerToFail:doubleTap];
//    [self.view addGestureRecognizer:singleTap];
//}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    /*
     *do something
     */
    NSLog(@"my handleSingleTap");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    NSLog(@"my handleDoubleTap");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
