//
//  MainMenuScene.m
//  ThrowABall
//
//  Created by MingChieh Chang on 8/19/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import "MainMenuScene.h"


@implementation MainMenuScene
-(id) init {
    self = [super init];
    if (self != nil) {
        MainMenuLayer *mainMenuLayer = [MainMenuLayer node];
        [self addChild:mainMenuLayer];
    }
    return self;
}
@end
