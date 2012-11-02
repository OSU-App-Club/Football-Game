//
//  GamePlayLayer.h
//  ThrowABall
//
//  Created by MingChieh Chang on 7/27/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Ball.h"
#import "Duck.h"
#import "SimpleAudioEngine.h"

#define HORIZ_SWIPE_DRAG_MIN  12
#define VERT_SWIPE_DRAG_MAX    4


@interface GamePlayLayer : CCLayer <UIAlertViewDelegate> {
    Ball *football;
    CCSprite *field;
    CCLabelTTF *scoreLabel;
    NSInteger score;
    NSMutableArray *ducksArray;
}

@property (assign,readwrite) NSInteger score;
@end
