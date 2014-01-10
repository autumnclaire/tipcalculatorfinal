//
//  TipViewController.m
//  TipCalculator2
//
//  Created by Autumn Victor on 1/9/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageControl;
- (IBAction) onTap:(id)sender;
- (void) updateValues;
- (void) onSettingsButton;
- (void) loadDefaults;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self loadDefaults];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing: YES];    //dismisses the keyboard
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray* tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipPercentageControl.selectedSegmentIndex] floatValue];
    
    float finalAmount = billAmount + tipAmount;
    
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", finalAmount ];
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
}

- (void) loadDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipIndex = [defaults integerForKey:@"defaultTipPercentageIndex"];
    if (defaultTipIndex < 0 || defaultTipIndex > self.tipPercentageControl.numberOfSegments) {
        defaultTipIndex = 1;
    }
    self.tipPercentageControl.selectedSegmentIndex = defaultTipIndex;
}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadDefaults];
    [self updateValues];
}



@end
