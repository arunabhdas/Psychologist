//
//  FaceView.m
//  Happiness
//
//  Created by  on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

#define DEFAULT_SCALE 0.70

@synthesize scale = _scale;
@synthesize dataSource = _dataSource;
//------------------------------------------------------
- (CGFloat) scale
{
	if (!_scale)
	{
		return DEFAULT_SCALE;
	}
	else
	{
		return _scale;
	}
}	
//------------------------------------------------------
- (void) setScale:(CGFloat)scale
{
	if (scale != _scale)
	{
		_scale = scale;
		NSLog(@"---------------------");
		[self setNeedsDisplay];
	}
}
//------------------------------------------------------
- (void) pinch:(UIPinchGestureRecognizer *) gesture
{
	if ((gesture.state == UIGestureRecognizerStateChanged) ||
		(gesture.state == UIGestureRecognizerStateEnded))
	{
		self.scale *= gesture.scale;
		gesture.scale = 1;
		
	}
}
//------------------------------------------------------
- (void) setup
{
	self.contentMode = UIViewContentModeRedraw;
}
//------------------------------------------------------
- (void) awakeFromNib
{
	[self setup];
}
//------------------------------------------------------
- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) 
	{
		// Initialization code
		[self setup];
	}
	return self;
}
//------------------------------------------------------

- (void) drawCircleAtPoint:(CGPoint) p
				withRadius:(CGFloat) radius
				 inContext:(CGContextRef)context


{
	UIGraphicsPushContext(context);
	
	CGContextBeginPath(context);
	
	CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
	
	CGContextStrokePath(context);
	
	UIGraphicsPopContext();
}



//----------------------------------------------
- (void)drawRect:(CGRect)rect
{
	// Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// draw face
	
	CGPoint midPoint;
	
	midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	
	midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
	
	CGFloat size = self.bounds.size.width/2;
	
	if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height / 2;
	
	size *= self.scale;
	
	CGContextSetLineWidth(context, 5.0);
	
	// create the color
	UIColor *mycolor= [UIColor colorWithRed:100.0/255.0 green:201.0/255.0 blue:102.0/255.0 alpha:1.0];
	
	[mycolor setStroke];
	
	[self drawCircleAtPoint:midPoint withRadius:size inContext:context];
	
	
	// draw eyes
	
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
	
	
	CGPoint eyePoint;
	eyePoint.x = midPoint.x - size * EYE_H;
	eyePoint.y = midPoint.y - size * EYE_V;
	
	[self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:context];
	eyePoint.x += size * EYE_H * 2;
	[self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:context];
	
	
	// draw mouth
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
	
	CGPoint mouthStart;
	mouthStart.x = midPoint.x - MOUTH_H * size;
	mouthStart.y = midPoint.y + MOUTH_V * size;
	CGPoint mouthEnd = mouthStart;
	mouthEnd.x += MOUTH_H * size * 2;
	CGPoint mouthCP1 = mouthStart;
	mouthCP1.x += MOUTH_H * size * 2/3;
	CGPoint mouthCP2 = mouthEnd;
	mouthCP2.x -= MOUTH_H * size * 2/3;
	
	float smile = [self.dataSource smileForFaceView:self];
	//	float smile = 0;
	NSLog(@"----------------------smile : %f", smile);
	
	if (smile < -1) smile = -1;
	
	if (smile > 1) smile = 1;
	
	CGFloat smileOffset = MOUTH_SMILE * size * smile;
	mouthCP1.y += smileOffset;
	mouthCP2.y += smileOffset;
	
	// get context
	CGContextBeginPath(context);
	
	CGContextMoveToPoint(context, mouthStart.x,  mouthStart.y);
	CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP2.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
	CGContextStrokePath(context);
	
	
	
}


@end
