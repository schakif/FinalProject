//
//  FlipsideViewController.h
//  Slider
//
//  Created by Steve Chakif on 4/6/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end


@interface FlipsideViewController : UIViewController{
    
    IBOutlet UIBarButtonItem *Refresh;
    IBOutlet UISegmentedControl *PuzzlePicture;
    IBOutlet UISwitch *CountMoves;
    IBOutlet UISwitch *Timer;
    IBOutlet UISegmentedControl *PuzzleLayoutX;
    IBOutlet UISegmentedControl *PuzzleLayoutY;
    
}

@property (retain, nonatomic) IBOutlet UIBarButtonItem *Refresh;
@property (retain, nonatomic) IBOutlet UISegmentedControl *PuzzlePicture;
@property (retain, nonatomic) IBOutlet UISwitch *CountMoves;
@property (retain, nonatomic) IBOutlet UISwitch *Timer;
@property (retain, nonatomic) IBOutlet UISegmentedControl *PuzzleLayoutX;
@property (retain, nonatomic) IBOutlet UISegmentedControl *PuzzleLayoutY;

@property (assign, nonatomic) IBOutlet id<FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)Refreshed:(id)sender;
- (IBAction)PuzzlePictured:(id)sender;
- (IBAction)CountMoved:(id)sender;
- (IBAction)Timered:(id)sender;
- (IBAction)PuzzleLayoutedX:(id)sender;
- (IBAction)PuzzleLayoutedY:(id)sender;



@end
