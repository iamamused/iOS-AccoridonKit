//
//  AKAccordionItemView.m
//  AccordionKit
//
//  Copyright (c) 2010, Jeffrey Sambells / TropicalPixels.
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without 
//  modification, are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this 
//  list of conditions and the following disclaimer.
//  
//  Redistributions in binary form must reproduce the above copyright notice, 
//  this list of conditions and the following disclaimer in the documentation 
//  and/or other materials provided with the distribution.
//  
//  Neither the name of the <ORGANIZATION> nor the names of its contributors may 
//  be used to endorse or promote products derived from this software without 
//  specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//  POSSIBILITY OF SUCH DAMAGE.

#import "AKAccordionBar.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation AKAccordionBar

@synthesize title = _title;
@synthesize icon = _icon;
@synthesize accordionDelegate = _accordionBarDelegate;
@synthesize label = _labelView;
@synthesize startColor, endColor;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image;
{
	if (self = [self initWithFrame:CGRectZero]) {
		if (title != nil) self.title = title;
		if (image != nil) self.icon = image;		
		self.startColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.35f];
		self.endColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.06f];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {

	if (self = [super initWithFrame:frame]) {
		// Add a gesture to allow us to pan the app to change views.
		UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_triggerDelegateSelect:)];
		[gesture setNumberOfTapsRequired:1];
		[gesture setNumberOfTouchesRequired:1];
		[self addGestureRecognizer:gesture];
		[gesture release];
		
		[self setBackgroundColor:[UIColor lightGrayColor]];

	}
	return self;
}

-(void)_triggerDelegateSelect:(UITapGestureRecognizer *)sender {	
	if (sender.state == UIGestureRecognizerStateEnded) {
		if (self.accordionDelegate != NULL) {
			[self.accordionDelegate didSelectBar:self];
		}	
	}
}

- (void)setTitle:(NSString *)title {
	
	[_title release];
	_title = nil;
	if (title == nil) return;
	_title = [title retain];
	
	if (_labelView == nil) {
		_labelView = [[UILabel alloc] initWithFrame:CGRectZero];
		[_labelView setBackgroundColor:[UIColor clearColor]];
		[_labelView setShadowColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f]];
		[_labelView setShadowOffset:CGSizeMake(-1.0f, -1.0f)];
		[self addSubview:_labelView];
		[_labelView setText:title];
	}
	[_labelView setText:title];
	
	[self setNeedsDisplay];
}

- (void)setIcon:(UIImage *)image {
	
	[_icon release];
	_icon = nil;
	if (image == nil) return;
	_icon = [image retain];
	
	if (_imageView == nil) {
		_imageView = [[UIImageView alloc] initWithImage:_icon];
		[self addSubview:_imageView];
	} else {
		[_imageView setImage:_icon];
	}
	
	[self setNeedsDisplay];
}

- (void)dealloc {
	[_title release];
	[_icon release];
	[_labelView release];
	[_imageView release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect 
{

	
	if (_labelView != nil) {
		CGRect lFrame = self.frame;
		lFrame.origin.x = (_icon == nil) ? 10 : _icon.size.width + 20;
		lFrame.origin.y = 0;
		[_labelView setFrame:lFrame];
	}
	
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	
	CGContextSaveGState(currentContext);
	CGContextSetLineWidth(currentContext, 1);

	// Top Highlight
	[[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f] setStroke];
	CGContextMoveToPoint(currentContext, 0.0f, 0.0f);
	CGContextAddLineToPoint(currentContext, self.frame.size.width, 0.0f );
	CGContextDrawPath(currentContext, kCGPathStroke);

	// Bottom Highlight
	[[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f] setStroke];
	CGContextMoveToPoint(currentContext, 0.0f, self.frame.size.height);
	CGContextAddLineToPoint(currentContext, self.frame.size.width, self.frame.size.height );
	CGContextDrawPath(currentContext, kCGPathStroke);
	CGContextRestoreGState(currentContext);	
	
	// Gloss
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    CGFloat locations[2] = { 0.0, 1.0 };
    NSArray *colors = [NSArray arrayWithObjects: 
		[self.startColor CGColor],
		[self.endColor CGColor],
		nil
	];
	
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColors(rgbColorspace, (CFArrayRef)colors, locations);
	
    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, midCenter, 0);
	
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace); 
	
}

@end
