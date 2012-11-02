//
//  GamePlayLayer.m
//  ThrowABall
//
//  Created by MingChieh Chang on 7/27/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import "GamePlayLayer.h"
#import <OpenGLES/EAGL.h>


#define SCALESIZE 10

@implementation GamePlayLayer
@synthesize score;
-(id) init {
    self = [super init];
    if (self != nil) {
        self.isTouchEnabled = YES;
        ducksArray = [[NSMutableArray alloc] init];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
       
        // ducks
        int distance[] = {150, 210, 250, 290, 340};
        Duck *duck;
        for (int i = 0; i < 5; i++) {
            duck = [Duck createDuck:@"duck.png"];
            
            [duck setPositionWithScaling:CGPointMake(winSize.width / 2, distance[i])];
            // position x            
            int rangeDuration =  duck.rightSide - duck.leftSide;
            int positionX = (arc4random() % rangeDuration) + duck.leftSide;
            [duck setPosition:CGPointMake(positionX, duck.position.y)];
                         
            [duck move];
            [self addChild:duck];
            [ducksArray addObject:duck];
            duck.score = i*2 + 2;
        }
        
        // football
        football = [Ball touchableSpriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"ball_small.png"]];
        football.position = CGPointMake(winSize.width/2, FOOTBALL_INITIAL_POSITION_Y);
        [self addChild:football];  
        
        // score label
        score = 0;
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", score] fontName:@"Marker Felt" fontSize:18];
        scoreLabel.position = CGPointMake(20, winSize.height - (scoreLabel.contentSize.height));
        [self addChild:scoreLabel];
        [self schedule:@selector(checkBallAndDuck:)];
        
        
        // Music
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Oregon state beavers fight song (short).mp3" loop:NO];
        NSTimeInterval duration = [CDAudioManager sharedManager].backgroundMusic.audioSourcePlayer.duration;
        [self schedule:@selector(checkIsEnd:) interval:duration];
    }
    return self;
}


-(void) checkIsEnd:(ccTime)dt {
    // TODO: open a new screen (pop up screen with score and options includes game center, facebook, play again)
    NSLog(@"Game should stop");
    [self unschedule:@selector(checkIsEnd:)];
    [self unschedule:@selector(checkBallAndDuck:)];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    UIView *view = [[CCDirector sharedDirector] openGLView];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:[NSString stringWithFormat:@"Your score: %d", score] delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Restart", nil];
    [view addSubview:myAlertView];
    [myAlertView show];
    [myAlertView release];
}


-(void) checkBallAndDuck:(ccTime)dt {
    //Note: Replace this hard code with a for loop once you get the chance
    CGFloat footballX = football.position.x - (football.contentSize.width / 2);
    CGFloat footballY = football.position.y + (football.contentSize.height/2) -  football.contentSize.height/3;
    CGRect ballRect = CGRectMake(footballX, footballY, football.contentSize.width, football.contentSize.height/3);
    for (int i = 0; i < 5; i++) {
        Duck *duck = [ducksArray objectAtIndex:i]; 
        CGFloat duckX = duck.position.x - (SCALESIZE - (i * 2));
        CGFloat duckY = duck.position.y - (SCALESIZE - (i * 2));
        CGRect duckRect = CGRectMake(duckX, duckY, SCALESIZE, SCALESIZE);
        if (CGRectIntersectsRect(duckRect, ballRect) && duck.state == kDuckStateNotHit) {
            // actions for original duck
            duck.state = kDuckStateHit;
            [duck changeImage:@"defeated_duck.png"];
            [duck stopAllActions];
            score = score + duck.score;
            [scoreLabel setString:[NSString stringWithFormat:@"%d", score]]; 
            [duck hittedAction];
            [football resetFootball];
        }
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    // football state
    football.state = kTouchableSpriteStateUngrabbed;
    // score label
    score = 0;
    [scoreLabel setString:[NSString stringWithFormat:@"%d", score]];
    [self schedule:@selector(checkBallAndDuck:)];
            
    // Music
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Oregon state beavers fight song (short).mp3" loop:NO];
    NSTimeInterval duration = [CDAudioManager sharedManager].backgroundMusic.audioSourcePlayer.duration;
    [self schedule:@selector(checkIsEnd:) interval:duration];
        

}

-(void) dealloc{
    [super dealloc];
}

- (void) draw {
    // field by cocos2d
    glEnable(GL_LINE_SMOOTH);
    
    // draw background
    glColor4ub(10, 190, 34, 255);
    const CGPoint squareVertices[] = { CGPointMake(2,2), CGPointMake(318, 2), CGPointMake(318, 400), CGPointMake(2, 400)};
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);    
    glVertexPointer(2, GL_FLOAT, 0, squareVertices);
    glDrawArrays(GL_TRIANGLE_FAN , 0, 4);
    CC_ENABLE_DEFAULT_GL_STATES();
    // draw lines    
    glColor4f(1.0, 1.0, 1.0, 1.0); 
    glLineWidth(.5f);
    ccDrawLine(CGPointMake(0, 75), CGPointMake(60, 400));
    ccDrawLine(CGPointMake(320, 75), CGPointMake(260, 400));
    
    ccDrawLine(CGPointMake(0, 75), CGPointMake(320, 75));
    ccDrawLine(CGPointMake(38.8, 210), CGPointMake(281, 210));
    ccDrawLine(CGPointMake(53.65, 290), CGPointMake(266.85, 290));
    ccDrawLine(CGPointMake(59.2, 360), CGPointMake(260.8, 360));
    ccDrawLine(CGPointMake(60, 400), CGPointMake(260, 400));
}
@end
