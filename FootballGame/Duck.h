//
//  Duck.h
//  ThrowABall
//
//  Created by MingChieh Chang on 8/21/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

#import "cocos2d.h"

typedef enum tagHitState{
    kDuckStateHit,
    kDuckStateNotHit
} DuckState;


@interface Duck : CCSprite {
    float actualDuration;
    float duckScale;
    BOOL duckRightDirection;
    CGSize scaleSize;
    DuckState state;
    double leftSide;
    double rightSide;
    int score;
}
@property(assign) float actualDuration;
@property(assign) float duckScale;
@property(assign) double leftSide;
@property(assign) double rightSide;
@property(assign) int score;
@property(nonatomic) CGSize scaleSize;
@property(nonatomic) DuckState state;
@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

- (void) setPositionWithScaling:(CGPoint)position;
- (void) move;
+ (id) createDuck: (NSString*)imageName ;
-(void) changeImage:(NSString *)imageName;
-(void) hittedAction;
- (void) setSpeed;
@end
