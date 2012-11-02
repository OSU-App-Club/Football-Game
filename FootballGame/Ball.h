//
//  Ball.h
//  ThrowABall
//
//  Created by MingChieh Chang on 8/18/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constant.h"

typedef enum tagTouchableSpriteState{
    kTouchableSpriteStateGrabbed,
    kTouchableSpriteStateUngrabbed
} TouchableSpriteState;

@interface Ball : CCSprite <CCTargetedTouchDelegate>{
@private
    TouchableSpriteState state;
    int endPosition;
    float footBallScale ;
}

@property(assign) TouchableSpriteState state;
@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

+ (id)touchableSpriteWithTexture:(CCTexture2D *)texture;
-(void) resetFootball;
@end
