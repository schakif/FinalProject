//
//  Tile.h
//  Slider
//
//  Created by Steve Chakif on 4/6/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tile : UIImageView {
    
    CGPoint originalPosition;
    CGPoint currentPosition;
    
}

@property (nonatomic, readwrite) CGPoint originalPosition;
@property (nonatomic, readwrite) CGPoint currentPosition;

@end
