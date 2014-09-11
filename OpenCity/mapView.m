//
//  mapView.m
//  OpenCity
//
//  Created by Apollo on 11/09/14.
//  Copyright (c) 2014 com.iosHello. All rights reserved.
//

#import "mapView.h"
#import "locationVC.h"
#import "dataClass.h"

@interface mapView () <GMSMapViewDelegate>

@property (strong, nonatomic) GMSCameraPosition *camera;
@property (strong, nonatomic) NSMutableSet *markers;
@property (strong, nonatomic) GMSMapView *mapView_;
@property (strong, nonatomic) locationVC *locationManager;
@property (strong, nonatomic) GMSMarker  *marker;

@end

@implementation mapView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

-(void)addMarker
{
    self.marker.map = nil;
    self.marker = [GMSMarker markerWithPosition:self.camera.target];
    self.marker.title = @"Ajouter un post-it";
    self.marker.map = self.mapView_;
}

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    self.marker.map = nil;
    self.marker = [GMSMarker markerWithPosition:coordinate];
    self.marker.title = @"Ajouter un post-it";
    self.marker.map = self.mapView_;
}

- (void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    
}

- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
}

- (void) mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    self.camera = position;
    self.marker.position = position.target;
}

-(void)changeCamera
{
    dataClass *obj = [dataClass getInstance];
    GMSCameraPosition *newPosition = [GMSCameraPosition cameraWithLatitude:obj.currentLocation.coordinate.latitude longitude:obj.currentLocation.coordinate.longitude zoom:15];
    [self.mapView_ setCamera:newPosition];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[locationVC alloc] init];
    [self.locationManager startManager:self];
    self.camera = [GMSCameraPosition cameraWithLatitude:45.755038
                                              longitude:4.85
                                                   zoom:15];
    self.mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:self.camera];
    self.mapView_.delegate = self;
    self.view = self.mapView_;
    self.mapView_.mapType = kGMSTypeNormal;
    self.mapView_.settings.compassButton = YES;
    self.mapView_.settings.myLocationButton = YES;
}

- (BOOL) didTapMyLocationButtonForMapView:(GMSMapView *)mapView
{
    [self.locationManager startTracking];
    NSLog(@"test");
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
