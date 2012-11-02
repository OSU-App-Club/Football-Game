//
//  GameManager.m
//  ThrowABall
//
//  Created by MingChieh Chang on 8/19/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//


#import "GameManager.h"

@implementation GameManager
static GameManager* _sharedGameManager = nil;
@synthesize isMusicOn;
@synthesize isSoundEffectsOn;

+(GameManager *) sharedGameManager
{
    @synchronized([GameManager class])
    {
        if (!_sharedGameManager) 
            [[self alloc] init];
        return _sharedGameManager;
    }
    return nil;
}

-(void)runSceneWithID:(SceneTypes)sceneID
{
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    
    switch (sceneID) {
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
//        case kIntroScene:
//            sceneToRun = [IntroScene node];            
        case kGameLevel: 
            sceneToRun = [GameScene node];
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil) {
        currentScene = oldScene;
        return;
    }
    // Menu Scenes have a value of < 100
    if (sceneID < 100) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) { CGSize screenSize =
            [CCDirector sharedDirector].winSizeInPixels;
            if (screenSize.width == 960.0f) {
                // iPhone 4 Retina
                [sceneToRun setScaleX:0.9375f];
                [sceneToRun setScaleY:0.8333f];
                CCLOG(@"GM:Scaling for iPhone 4 (retina)");
            } else {
                [sceneToRun setScaleX:0.4688f];
                [sceneToRun setScaleY:0.4166f];
                CCLOG(@"GM:Scaling for iPhone 3G(non-retina)");
            } }
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    } else {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
}

// TODO
//-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen
//{
//    
//}

+(id) alloc
{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil, 
                 @"Attempted to allocate a second instance of the GameManager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil; 
}

- (id)init
{
    self = [super init];
    if (self) {
        isMusicOn = YES;
        isSoundEffectsOn = YES;
        currentScene = kNoSceneUninitialized;
    }    
    return self;
}

@end
