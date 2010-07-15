//
//  AKView.m
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

#import "AccordionKit.h"

@interface AKAccordionView (Private)
- (void)_placeToolbars;
@end


@implementation AKAccordionView

@synthesize delegate = _delegate;
@synthesize bars = _bars;
@synthesize selectedBar = _selectedBar;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)rect;
{
	[super setFrame:rect];
	[self _placeToolbars];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Creation

- (void)setItems:(NSArray *)items;
{
	[_bars release];
	_bars = nil;
	_bars = [items retain];

	for (UIView *view in [self subviews]) {
		[view removeFromSuperview];
	}

	self.selectedBar = nil;
	if ([items count] > 0) {
		self.selectedBar = [_bars objectAtIndex:0];	
	}
	
	for (AKAccordionBar *b in _bars) {
		[b setAccordionDelegate:self];
	}
	
	[self _placeToolbars];
	
}

#pragma mark -
#pragma mark AKAccordionBarDelegate

- (void)didSelectBar:(AKAccordionBar *)bar 
{
	NSUInteger barIndex = [_bars indexOfObject:bar];
	_selectedBar = [_bars objectAtIndex:barIndex];
	[self _placeToolbars];
}
		 
		 
- (void)_placeToolbars;
{
	
	// Are there items?
	if ([_bars count] == 0) return;
		
	// Figure out which item is going to be the "open" one.
	AKAccordionBar *open = self.selectedBar;
	if (open == nil) {
		open = [_bars objectAtIndex:0];
	}
	
	int selectionIndex = [_bars indexOfObject:open];
	
	// Get the view for the new open item
	CGRect closedFrame = self.frame;
	closedFrame.size.height = 0;
	UIView *newSelection = [self.delegate accordionView:self viewForIndex:selectionIndex];
	[newSelection setFrame:closedFrame];


	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	if (_selectedBarView != nil) {
		CGRect closed = _selectedBarView.frame;
		if (selectionIndex < _previousSelectedIndex) {
			closed.origin.y = closed.origin.y + closed.size.height;
		}
		closed.size.height = 0.0f;
		
		[_selectedBarView setFrame:closed];	
		[_selectedBarView setClipsToBounds:YES];
	}
	
	UIView *previous = nil;
	for (int index = 0; index < [_bars count]; index++) {

		CGRect f = self.frame;
		f.origin.x = 0;
		f.origin.y = previous == nil ? 0.0f : previous.frame.origin.y + previous.frame.size.height;
		f.size.height = 44.0f;
		
		UIView *v;
		
		v = [_bars objectAtIndex:index];
		[v setFrame:f];
		[self addSubview:v];
		
		if ([v isEqual:open]) {
			
			CGRect openFrame = self.frame;
			openFrame.origin.y = f.origin.y + f.size.height;
			openFrame.size.height = openFrame.size.height - (44.0f * [_bars count]);

			v = _selectedBarView = newSelection;
			[_selectedBarView setFrame:openFrame];
			[self insertSubview:_selectedBarView atIndex:0];
		}
		
		previous = v;
	}
	
	[UIView commitAnimations];
	_previousSelectedIndex = selectionIndex;
	
}


//- (UIView *)accordionView:(AKAccordionView *)accordionView viewForIndex:(NSUInteger)index;   // custom view for header. will be adjusted to default or specified header height

- (void)setItems:(NSArray *)items animated:(BOOL)animated;
{
	[self setItems:items];
}

@end
