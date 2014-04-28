//
//  FlipsideViewController.m
//  Slider
//
//  Created by Steve Chakif on 4/6/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController
@synthesize delegate = _delegate;
@synthesize Refresh;
@synthesize PuzzlePicture;
@synthesize CountMoves;
@synthesize Timer;
@synthesize PuzzleLayoutX, PuzzleLayoutY;

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
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    switch ([prefs integerForKey:@"PuzzlePicture"]) {
        case 0:
            PuzzlePicture.selectedSegmentIndex = 0;
            break;
        case 1:
            PuzzlePicture.selectedSegmentIndex = 1;
            break;
        case 2:
            PuzzlePicture.selectedSegmentIndex = 2;
            break;
        case 3:
            PuzzlePicture.selectedSegmentIndex = 3;
            break;
        default:
            break;
    }
    
    
    if ([prefs boolForKey:@"CountMoves"] == TRUE) {
        CountMoves.on = TRUE;
    } else {
        CountMoves.on = FALSE;
    }
    
    if ([prefs boolForKey:@"Timer"] == TRUE) {
        Timer.on = TRUE;
    } else {
        Timer.on = FALSE;
    }
    
    
    switch ([prefs integerForKey:@"PuzzleLayoutX"]) {
        case 0:
            PuzzleLayoutX.selectedSegmentIndex = 0;
            break;
        case 1:
            PuzzleLayoutX.selectedSegmentIndex = 1;
            break;
        case 2:
            PuzzleLayoutX.selectedSegmentIndex = 2;
            break;
        case 3:
            PuzzleLayoutX.selectedSegmentIndex = 3;
            break;
        default:
            break;
    }
    
    switch ([prefs integerForKey:@"PuzzleLayoutY"]) {
        case 0:
            PuzzleLayoutY.selectedSegmentIndex = 0;
            break;
        case 1:
            PuzzleLayoutY.selectedSegmentIndex = 1;
            break;
        case 2:
            PuzzleLayoutY.selectedSegmentIndex = 2;
            break;
        case 3:
            PuzzleLayoutY.selectedSegmentIndex = 3;
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)Refreshed:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:TRUE forKey:@"Refresh"];
}

- (IBAction)PuzzlePictured:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    switch (PuzzlePicture.selectedSegmentIndex) {
        case 0:
            [prefs setInteger:0 forKey:@"PuzzlePicture"];
            break;
        case 1:
            [prefs setInteger:1 forKey:@"PuzzlePicture"];
            break;
        case 2:
            [prefs setInteger:2 forKey:@"PuzzlePicture"];
            break;
        case 3:
            [prefs setInteger:3 forKey:@"PuzzlePicture"];
            break;
        default:
            break;
    }
}

- (IBAction)CountMoved:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (CountMoves.on == TRUE) {
        [prefs setBool:TRUE forKey:@"CountMoves"];
    } else {
        [prefs setBool:FALSE forKey:@"CountMoves"];
    }
}

- (IBAction)Timered:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (Timer.on == TRUE) {
        [prefs setBool:TRUE forKey:@"Timer"];
    } else {
        [prefs setBool:FALSE forKey:@"Timer"];
    }
}

- (IBAction)PuzzleLayoutedX:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    switch (PuzzleLayoutX.selectedSegmentIndex) {
        case 0:
            [prefs setInteger:0 forKey:@"PuzzleLayoutX"];
            break;
        case 1:
            [prefs setInteger:1 forKey:@"PuzzleLayoutX"];
            break;
        case 2:
            [prefs setInteger:2 forKey:@"PuzzleLayoutX"];
            break;
        case 3:
            [prefs setInteger:3 forKey:@"PuzzleLayoutX"];
            break;
        default:
            break;
    }
}

- (IBAction)PuzzleLayoutedY:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    switch (PuzzleLayoutY.selectedSegmentIndex) {
        case 0:
            [prefs setInteger:0 forKey:@"PuzzleLayoutY"];
            break;
        case 1:
            [prefs setInteger:1 forKey:@"PuzzleLayoutY"];
            break;
        case 2:
            [prefs setInteger:2 forKey:@"PuzzleLayoutY"];
            break;
        case 3:
            [prefs setInteger:3 forKey:@"PuzzleLayoutY"];
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
