//
//  MainMenuLayer.m
//  ThrowABall
//
//  Created by MingChieh Chang on 8/19/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import "MainMenuLayer.h"


@implementation MainMenuLayer

-(void)playScene:(CCMenuItemFont*)itemPassedIn {
    if ([itemPassedIn tag] == 1) {
        CCLOG(@"Tag 1 found, Scene 1");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel];
    } else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
        CCLOG(@"Placeholder for next chapters");
    }
}

-(void) displayMainMenu
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (!sceneSelectMenu) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    
    // Buttons
    CCMenuItemFont *play = [CCMenuItemFont itemFromString:@"Play" target:self selector:@selector(playScene:)];
    [play setTag:kMainMenuScene];
    [play setFontSize:64];
//    CCMenuItemImage *playButton = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play.png" target:self selector:@selector(playScene:)];
//    [playButton setTag:kMainMenuTagValue];
    
//    mainMenu = [CCMenu menuWithItems:playButton, nil];
     mainMenu = [CCMenu menuWithItems:play, nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition:ccp(screenSize.width /2 , screenSize.height / 2)];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
}

-(id) init 
{
    self = [super init];
    if (self != nil) {
        [self displayMainMenu];
    }
    return self;
}

@end
