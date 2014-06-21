//
//  LouverDetailViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 21/06/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "LouverDetailViewController.h"
#import "Louver.h"

@interface LouverDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uiLabelUp;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelDown;
@property (weak, nonatomic) IBOutlet UISlider *uiSlider;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelInProgress;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *uiProgress;

@property Louver* CurrentLouver;
@property NSTimer *Timer;

@end

@implementation LouverDetailViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    _uiLabelUp.text = NSLocalizedString(@"LouverUp", nil);
    _uiLabelDown.text = NSLocalizedString(@"LouverDown", nil);
    [_uiSlider setValue:_CurrentLouver.HideRatioInPercent.floatValue];
    _uiLabelInProgress.hidden = true;
}

-(void)viewWillDisappear:(BOOL)animated
{
    _CurrentLouver.HideRatioInPercent = [NSNumber numberWithFloat:_uiSlider.value];
    _uiLabelInProgress.hidden = true;
    [_uiProgress stopAnimating];
    [_Timer invalidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onSliderValueChanged:(id)sender
{
    int sec = (_uiSlider.value-_CurrentLouver.HideRatioInPercent.floatValue)/10.0;
    if (sec==0)
        return;
    _uiLabelInProgress.hidden = false;
    [_uiProgress startAnimating];
    if (_Timer)
        return;
    _Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];

}

-(void)onTimer
{
    int current = _CurrentLouver.HideRatioInPercent.intValue;
    int sec = (_uiSlider.value-current)/10.0;
    if (sec == 0)
    {
        [_Timer invalidate];
        _Timer = NULL;
        _CurrentLouver.HideRatioInPercent = [NSNumber numberWithFloat:_uiSlider.value];
        _uiLabelInProgress.hidden = true;
        [_uiProgress stopAnimating];
        return;
    }
    
    _CurrentLouver.HideRatioInPercent = [NSNumber numberWithInt:current + (abs(sec)/sec*10)];
}


#pragma mark - ApplianceDetailProtocol

-(void)setAppliance:(Appliance *)appliance
{
    _CurrentLouver = (Louver*)appliance;
}

@end
