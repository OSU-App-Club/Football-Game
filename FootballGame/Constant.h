//
//  Constant.h
//  ThrowABall
//
//  Created by MingChieh Chang on 8/19/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#ifndef ThrowABall_Constant_h
#define ThrowABall_Constant_h
#endif

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20
#define FOOTBALL_INITIAL_POSITION_Y 20 


typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kOptionsScene=2,
    kCreditsScene=3,
    kIntroScene=4,
    kLevelCompleteScene=5,
    kGameLevel=101,
//    kGameLevel2=102,
//    kGameLevel3=103,
//    kGameLevel4=104,
//    kGameLevel5=105,
    kCutSceneForLevel2=201
} SceneTypes;

typedef enum {
    kLinkTypeBookSite,
    kLinkTypeDeveloperSiteRod,
    kLinkTypeDeveloperSiteRay,
    kLinkTypeArtistSite,
    kLinkTypeMusicianSite
} LinkTypes;


