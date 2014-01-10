//
//  SettingsViewController.m
//  TipCalculator2
//
//  Created by Autumn Victor on 1/9/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercentageControl;
- (IBAction)onValueChanged:(id)sender;
- (void) updateDefaults;
- (void) setDefaults;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [self setDefaults];
    }
    return self;
}

- (IBAction)onValueChanged:(id)sender {
    [self updateDefaults];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDefaults];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipIndex = [defaults integerForKey:@"defaultTipPercentageIndex"];
    if (defaultTipIndex < 0 || defaultTipIndex >= self.defaultTipPercentageControl.numberOfSegments) {
        self.defaultTipPercentageControl.selectedSegmentIndex = 1;
        [self updateDefaults];
    } else {
        self.defaultTipPercentageControl.selectedSegmentIndex = defaultTipIndex;
    }
}

- (void) updateDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: self.defaultTipPercentageControl.selectedSegmentIndex forKey:@"defaultTipPercentageIndex"];
    [defaults synchronize];
}

@end
