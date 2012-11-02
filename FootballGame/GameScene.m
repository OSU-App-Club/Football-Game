//
//  GameScene.m
//  ThrowABall
//
//  Created by MingChieh Chang on 7/27/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
-(id) init {
    self = [super init];
    if (self != nil) {
        GamePlayLayer *gamePlayLayer = [GamePlayLayer node];
        [self addChild:gamePlayLayer];
    }
    return self;
}
@end
