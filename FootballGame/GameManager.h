//
//  GameManager.h
//  ThrowABall
//
//  Created by MingChieh Chang on 8/19/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#import "GameScene.h"

@interface GameManager : NSObject {
    BOOL isMusicOn;
    BOOL isSoundEffectsOn;
    SceneTypes currentScene;
}

@property (readwrite) BOOL isMusicOn;
@property (readwrite) BOOL isSoundEffectsOn;

+(GameManager *) sharedGameManager;
-(void)runSceneWithID:(SceneTypes)sceneID;
// TODO
//-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen;
@end
