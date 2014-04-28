//
//  SliderViewController.h
//  Slider
//
//  Created by Steve Chakif on 4/6/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tile.h"
#import "FlipsideViewController.h"

typedef enum {
    NONE = 0,
    UP = 1,
    DOWN = 2,
    LEFT = 3,
    RIGHT = 4
} ShuffleMove;


@interface SliderViewController : UIViewController <FlipsideViewControllerDelegate> {
    CGFloat tileWidth;
    CGFloat tileHeight;
    
    NSMutableArray *tiles;
    CGPoint blankPosition;
    
    NSTimer *timer;
    Tile *tileImageView;
    
}

- (IBAction)showInfo:(id)sender;

@property (nonatomic, retain) NSMutableArray *tiles;
@property (nonatomic, retain) Tile *tileImageView;

- (void) initPuzzle:(NSString *) imagePath;

- (ShuffleMove) validMove:(Tile *) tile;
- (void) movePiece:(Tile *)tile withAnimation:(BOOL)animate;
- (void) movePiece:(Tile *)tile inDirectionX:(NSInteger)dx inDirectionY:(NSInteger)dy withAnimation:(BOOL)animate;
- (void) shuffle;

- (Tile *) getPieceAtPoint:(CGPoint) point;
- (BOOL) puzzleCompleted;

@end
