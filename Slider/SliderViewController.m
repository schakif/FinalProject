//
//  SliderViewController.m
//  Slider
//
//  Created by Steve Chakif on 4/6/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "SliderViewController.h"

#define TILE_SPACING 4
#define SHUFFLE_NUMBER 100

@interface SliderViewController ()

@end

@implementation SliderViewController
@synthesize tiles, tileImageView;

int NUM_HORIZONTAL_PIECES = 3;
int NUM_VERTICAL_PIECES = 3;
int countmove = 0;
int thetime = 0;


- (void)viewDidLoad
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.tiles = [[NSMutableArray alloc] init];
	
	NSString *Pic = [NSString stringWithFormat:@"picture%d.png", [prefs integerForKey:@"PuzzlePicture"]];
    [self initPuzzle:Pic];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) initPuzzle:(NSString *)imagePath {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	UIImage *orgImage = [UIImage imageNamed:imagePath];
	
	if( orgImage == nil ){
		return;
	}
    
    if (tileImageView != nil && [prefs boolForKey:@"Refresh"] == TRUE) {
        for (tileImageView in tiles) {
            [tileImageView removeFromSuperview];
        }
    }
	
	[self.tiles removeAllObjects];
	
	tileWidth = orgImage.size.width/NUM_HORIZONTAL_PIECES;
	tileHeight = orgImage.size.height/NUM_VERTICAL_PIECES;
	
	blankPosition = CGPointMake( NUM_HORIZONTAL_PIECES-1, NUM_VERTICAL_PIECES-1 );
	
	for( int x=0; x<NUM_HORIZONTAL_PIECES; x++ ){
		for( int y=0; y<NUM_VERTICAL_PIECES; y++ ){
			CGPoint orgPosition = CGPointMake(x,y);
			
			if( blankPosition.x == orgPosition.x && blankPosition.y == orgPosition.y ){
				continue;
			}
			
			CGRect frame = CGRectMake(tileWidth*x, tileHeight*y,
									  tileWidth, tileHeight );
			CGImageRef tileImageRef = CGImageCreateWithImageInRect( orgImage.CGImage, frame );
			UIImage *tileImage = [UIImage imageWithCGImage:tileImageRef];
			
			CGRect tileFrame =  CGRectMake((tileWidth+TILE_SPACING)*x, (tileHeight+TILE_SPACING)*y,
										   tileWidth, tileHeight );
			
			tileImageView = [[Tile alloc] initWithImage:tileImage];
			tileImageView.frame = tileFrame;
			tileImageView.originalPosition = orgPosition;
			tileImageView.currentPosition = orgPosition;
            
			CGImageRelease( tileImageRef );
			
			[tiles addObject:tileImageView];
			
			// now add to view
			[self.view insertSubview:tileImageView atIndex:0];
		}
	}
	
	[self shuffle];
}

// Tile handling methods

- (ShuffleMove) validMove:(Tile *)tile {
    // blank spot above current piece
	if( tile.currentPosition.x == blankPosition.x && tile.currentPosition.y == blankPosition.y+1 ){
		return UP;
	}
	
	// blank splot below current piece
	if( tile.currentPosition.x == blankPosition.x && tile.currentPosition.y == blankPosition.y-1 ){
		return DOWN;
	}
	
	// blank spot left of the current piece
	if( tile.currentPosition.x == blankPosition.x+1 && tile.currentPosition.y == blankPosition.y ){
		return LEFT;
	}
	
	// blank spot right of the current piece
	if( tile.currentPosition.x == blankPosition.x-1 && tile.currentPosition.y == blankPosition.y ){
		return RIGHT;
	}
    return NONE;
}

- (void) movePiece:(Tile *)tile withAnimation:(BOOL)animate {
    switch ([self validMove:tile]) {
		case UP:
			[self movePiece:tile
			   inDirectionX:0 inDirectionY:-1 withAnimation:animate];
			break;
		case DOWN:
			[self movePiece:tile
			   inDirectionX:0 inDirectionY:1 withAnimation:animate];
			break;
		case LEFT:
			[self movePiece:tile
			   inDirectionX:-1 inDirectionY:0 withAnimation:animate];
			break;
		case RIGHT:
			[self movePiece:tile
			   inDirectionX:1 inDirectionY:0 withAnimation:animate];
			break;
		default:
			break;
	}
}

- (void) movePiece:(Tile *)tile inDirectionX:(NSInteger)dx inDirectionY:(NSInteger)dy withAnimation:(BOOL)animate {
    tile.currentPosition = CGPointMake( tile.currentPosition.x+dx,tile.currentPosition.y+dy);
	blankPosition = CGPointMake( blankPosition.x-dx, blankPosition.y-dy );
	
	int x = tile.currentPosition.x;
	int y = tile.currentPosition.y;
	
	if( animate ){
		[UIView beginAnimations:@"frame" context:nil];
	}
	tile.frame = CGRectMake((tileWidth+TILE_SPACING)*x, (tileHeight+TILE_SPACING)*y,
                            tileWidth, tileHeight );
	if( animate ){
		[UIView commitAnimations];
	}
}

- (void) shuffle {
    NSMutableArray *validMoves = [[NSMutableArray alloc] init];
	
	srandom(time(NULL));
	
	for( int i=0; i<SHUFFLE_NUMBER; i++ ){
		[validMoves removeAllObjects];
		
		for( Tile *t in tiles ){
			if( [self validMove:t] != NONE ){
				[validMoves addObject:t];
			}
		}
		
		NSInteger pick = random()%[validMoves count];
		[self movePiece:(Tile *)[validMoves objectAtIndex:pick] withAnimation:NO];
	}
	
}


//Helper methods
- (Tile *) getPieceAtPoint:(CGPoint)point {
    CGRect touchRect = CGRectMake(point.x, point.y, 1.0, 1.0);
	
	for( Tile *t in tiles ){
		if( CGRectIntersectsRect(t.frame, touchRect) ){
			return t;
		}
	}
	return nil;
}

- (BOOL) puzzleCompleted {
    for( Tile *t in tiles ){
		if( t.originalPosition.x != t.currentPosition.x || t.originalPosition.y != t.currentPosition.y ){
			return NO;
		}
	}
	
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:self.view];
	
	Tile *t = [self getPieceAtPoint:currentTouch];
	if( t != nil ){
        //Start the game timer
        if (timer == nil && [prefs boolForKey:@"Timer"] == TRUE) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        }
        //Move the pieces
		[self movePiece:t withAnimation:YES];
        //Count the moves
        if ([prefs boolForKey:@"CountMoves"] == TRUE) {
            countmove++;
        }
		if( [self puzzleCompleted] ){
            NSString *Winning;
            
            if ([prefs boolForKey:@"CountMoves"] == TRUE && [prefs boolForKey:@"Timer"] == TRUE) {
                Winning = [NSString stringWithFormat:@"It took you: %i Moves in %i Seconds!", countmove, thetime];
            } else if ([prefs boolForKey:@"CountMoves"] == TRUE && [prefs boolForKey:@"Timer"] == FALSE) {
                Winning = [NSString stringWithFormat:@"It took you: %i Moves", countmove];
            } else if ([prefs boolForKey:@"CountMoves"] == FALSE && [prefs boolForKey:@"Timer"] == FALSE) {
                Winning = [NSString stringWithFormat:@"Great Job!"];
            } else if ([prefs boolForKey:@"CountMoves"] == FALSE && [prefs boolForKey:@"Timer"] == TRUE) {
                Winning = [NSString stringWithFormat:@"It took you: %i Seconds", thetime];
            }
            
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"You Won!"
                                                              message:Winning
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
            
            countmove = 0;
            thetime = 0;
            if (timer != nil) {
                [timer invalidate];
                timer = nil;
            }
		}
	}
}

- (void)onTimer {
    thetime++;
}

//View props
- (void) viewDidUnload {
    [super viewDidUnload];
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


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //Perform settings changes to the Main View
    switch ([prefs integerForKey:@"PuzzleLayoutX"]) {
        case 0:
            NUM_HORIZONTAL_PIECES = 2;
            break;
        case 1:
            NUM_HORIZONTAL_PIECES = 3;
            break;
        case 2:
            NUM_HORIZONTAL_PIECES = 4;
            break;
        case 3:
            NUM_HORIZONTAL_PIECES = 5;
            break;
        default:
            break;
    }
    
    switch ([prefs integerForKey:@"PuzzleLayoutY"]) {
        case 0:
            NUM_VERTICAL_PIECES = 2;
            break;
        case 1:
            NUM_VERTICAL_PIECES = 3;
            break;
        case 2:
            NUM_VERTICAL_PIECES = 4;
            break;
        case 3:
            NUM_VERTICAL_PIECES = 5;
            break;
        default:
            break;
    }
    
    if ([prefs boolForKey:@"Refresh"] == TRUE) {
        
        countmove = 0;
        thetime = 0;
        if (timer != nil) {
            [timer invalidate];
            timer = nil;
        }
        
        NSString *Pic = [NSString stringWithFormat:@"picture%d.png", [prefs integerForKey:@"PuzzlePicture"]];
        [self initPuzzle:Pic];
    }
}

- (IBAction)showInfo:(id)sender {
    FlipsideViewController *controller = [[FlipsideViewController alloc] init];
    controller.delegate = self;
    
    [controller setModalPresentationStyle:UIModalPresentationFullScreen];
    [controller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
