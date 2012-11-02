//
//  Duck.m
//  ThrowABall
//
//  Created by MingChieh Chang on 8/21/11.
//  Copyright 2011 Oregon State University. All rights reserved.
//

#import "Duck.h"


@implementation Duck

@synthesize actualDuration, duckScale, scaleSize, state, score, leftSide, rightSide;

+ (id) createDuck:(NSString*)imageName
{
    return [[[self alloc] initWithTexture:[[CCTextureCache sharedTextureCache] addImage: imageName]] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {        
        // Determine speed of the target
        duckRightDirection = NO;
        [self setSpeed];
        state = kDuckStateNotHit;
        score = 0;
	}
	
	return self;
}

- (void) setSpeed{
    float minDuration = 3.0;
    float maxDuration = 10.0;
    int rangeDuration = maxDuration - minDuration;    
    actualDuration = (arc4random() % rangeDuration) + minDuration;
}

-(void)changeImage:(NSString *)imageName{
    [self setTexture:[[CCTextureCache sharedTextureCache] addImage:imageName]];
}

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

- (void) move
{
    int positionX = 0;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if (duckRightDirection) {
        self.scaleX = -duckScale;
        positionX = winSize.width;
    } else if (self.scaleX == 0){
        self.scaleX = duckScale;   
    }
    id move_act = [CCMoveTo actionWithDuration:actualDuration position:ccp(positionX, self.position.y)];
    [self runAction:move_act];
    [self schedule:@selector(changeDirection:) interval:0.3];
}

-(void) hittedAction { 
    [self setSpeed];
    [self unschedule:@selector(changeDirection:)];
    [self schedule:@selector(callToWork:) interval:3];
}

-(void) callToWork:(ccTime) dt{
    [self unschedule:@selector(callToWork:)];
    [self changeImage:@"duck.png"];
    self.state = kDuckStateNotHit;
    [self move];
}

- (void) changeDirection:(ccTime)dt
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int realWidth = self.scaleSize.width;
    if ((self.position.x - realWidth/2) < leftSide) { 
        [self setSpeed];
        duckRightDirection = YES;
        [self stopAllActions];
        id move_act = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width, self.position.y)];
        self.scaleX = -duckScale;
        [self runAction:move_act];
    } else if ((self.position.x + realWidth/2) > rightSide){
        [self setSpeed];
        duckRightDirection = NO;
        [self stopAllActions];
        id move_act = [CCMoveTo actionWithDuration:actualDuration position:ccp(0, self.position.y)];
        self.scaleX = duckScale;
        [self runAction:move_act];
    }
}


- (void) setPositionWithScaling:(CGPoint)position
{
    //Note:changing the contentSize seems to have an effect on the position of the duck
    //this can pose a problem.     
    [super setPosition:position];    
    //Note: The football is always hitting the duck.
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    duckScale = ((winSize.height - position.y) / winSize.height) * 0.8;
    self.scaleSize = CGSizeMake(self.contentSize.width * duckScale, self.contentSize.height * duckScale);
    self.scale = duckScale;
    
    // set boundary
    leftSide = 0.185 * (position.y - 75);
    rightSide = winSize.width - self.scaleSize.width - leftSide;
}

@end
