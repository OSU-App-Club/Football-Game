//
//  Ball.m
//  ThrowABall
//
//  Created by MingChieh Chang on 8/18/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import "Ball.h"


@implementation Ball
@synthesize state;
- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

+ (id)touchableSpriteWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
        
		state = kTouchableSpriteStateUngrabbed;
	}

    footBallScale = 1.0;    
	return self;
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
	CGRect r = [self rectInPixels];
	return CGRectContainsPoint(r, p);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (state != kTouchableSpriteStateUngrabbed) return NO;
	if ( ![self containsTouchLocation:touch] ) return NO;
    
    self.position = CGPointMake(self.position.x, self.position.y - 5);
	state = kTouchableSpriteStateGrabbed;
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state == kTouchableSpriteStateGrabbed, @"TouchableSprite - Unexpected state!");	
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	self.position = CGPointMake(touchPoint.x, self.position.y);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state == kTouchableSpriteStateGrabbed, @"TouchableSprite - Unexpected state!");    
    self.position = CGPointMake(self.position.x, self.position.y + 5);
    
    CGPoint location =  [self convertTouchToNodeSpace:touch];
    float distance = location.y - self.position.y;
    if (distance < 0){
        state = kTouchableSpriteStateUngrabbed;
        return;
    }
    // Note: figure out that if distance is less than a minimum number, we need to use a constant distance.
    if (distance < 40) {
        distance = 150;
    } else {
        distance = 400;
    }
    endPosition = distance;
    id actionMove = [CCMoveTo actionWithDuration:1.0 position:ccp(self.position.x, endPosition)];

    id actionMoveDone = [CCCallFunc actionWithTarget:self selector:@selector(footballMoveFinished:)];

    id repeatAction = [CCRepeatForever actionWithAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    id scaleAction = [CCScaleTo actionWithDuration:1 scale:0.1];
    
    [self runAction:repeatAction];
    [self runAction:scaleAction];
}


- (void) footballMoveFinished:(id *)sender
{
    if ((self.position.y + (self.contentSize.height/ 4)) > endPosition) {
        [self resetFootball];
    }
}

-(void) resetFootball{
    [self stopAllActions];
    id moveBack = [CCMoveTo actionWithDuration:1 position:CGPointMake(self.position.x, (self.position.y - 3))];
    [moveBack setTag:1];
    [self runAction:moveBack];
    [self schedule:@selector(checkRunning:)];
}

-(void)checkRunning:(ccTime) dt {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if ([self numberOfRunningActions] == 0) {
        [self unschedule:@selector(checkRunning:)];
        self.position = CGPointMake(winSize.width / 2, FOOTBALL_INITIAL_POSITION_Y);
        state = kTouchableSpriteStateUngrabbed;
        footBallScale = 1.0;
        self.scale = footBallScale;        
    }
}
@end
