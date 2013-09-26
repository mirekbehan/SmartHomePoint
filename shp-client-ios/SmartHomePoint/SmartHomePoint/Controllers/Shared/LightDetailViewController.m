//
//  LightDetailViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 9/22/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "LightDetailViewController.h"
#import "ISColorWheel.h"
#import "Light.h"

@interface LightDetailViewController () <ISColorWheelDelegate>
@property Light* CurrentLight;
@end

@implementation LightDetailViewController


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_slider addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    ISColorWheel* colorWheel = (ISColorWheel*)_colorWheel;
    colorWheel.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    ISColorWheel* colorWheel = (ISColorWheel*)_colorWheel;
    [colorWheel setCurrentColor:_CurrentLight.Color];
    [colorWheel setBrightness:1.0];
    [colorWheel updateImage];
    _slider.value = _CurrentLight.Dim.floatValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeBrightness:(UISlider*)sender
{
/*    ISColorWheel* colorWheel = (ISColorWheel*)_colorWheel;
    [colorWheel setBrightness:_slider.value];
    [colorWheel updateImage];
    _well.backgroundColor = colorWheel.currentColor;
*/
    _CurrentLight.Dim = [NSNumber numberWithFloat:_slider.value];
}

- (void)colorWheelDidChangeColor:(ISColorWheel *)colorWheel
{
    _well.backgroundColor = colorWheel.currentColor;
    _CurrentLight.Color = colorWheel.currentColor;
}

#pragma mark - ApplianceDetailProtocol

-(void)setAppliance:(Appliance *)appliance
{
    _CurrentLight = (Light*)appliance;
}

@end
