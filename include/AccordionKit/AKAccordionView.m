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


@implementation AKAccordionView

@synthesize delegate = _delegate;
@synthesize items = _items;
@synthesize selectedItem = _selectedItem;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Creation

- (void)setItems:(NSArray *)items;
{
	[_items release];
	_items = nil;
	_items = [items retain];

	for (UIView *view in [self subviews]) {
		[view removeFromSuperview];
	}

	self.selectedItem = nil;
	if ([items count] > 0) {
		self.selectedItem = [_items objectAtIndex:0];	
	}

	[_bars release];
	_bars = nil;
	_bars = [[NSMutableArray alloc] initWithCapacity:[_items count]];
	
	for (AKAccordionItem *i in _items) {
		AKAccordionBar *v = [[AKAccordionBar alloc] initWithFrame:CGRectNull];
		[v setBackgroundColor:[UIColor lightGrayColor]];
		[v setTitle:[i title]];
		[v setIcon:[i image]];
		[v setAccordionDelegate:self];
		[_bars addObject:v];
		[v release];
	}
	
	[self _placeToolbars];
	
}

#pragma mark -
#pragma mark AKAccordionBarDelegate

- (void)didSelectBar:(AKAccordionBar *)bar 
{
	NSUInteger barIndex = [_bars indexOfObject:bar];
	_selectedItem = [_items objectAtIndex:barIndex];
	[self _placeToolbars];
}
		 
		 
- (void)_placeToolbars;
{
	
	// Are there items?
	if ([_items count] == 0) return;
		
	// Figure out which item is going to be the "open" one.
	AKAccordionItem *open = self.selectedItem;
	if (open == nil) {
		open = [_items objectAtIndex:0];
	}
	
	int selectionIndex = [_items indexOfObject:open];
	
	// Get the view for the new open item
	CGRect closedFrame = self.frame;
	closedFrame.size.height = 0;
	UIView *newSelection = [self.delegate accordionView:self viewForIndex:selectionIndex];
	[newSelection setFrame:closedFrame];


	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	if (_selectedItemView != nil) {
		CGRect closed = _selectedItemView.frame;
		if (selectionIndex < _previousSelectedIndex) {
			closed.origin.y = closed.origin.y + closed.size.height;
		}
		closed.size.height = 0.0f;
		
		[_selectedItemView setFrame:closed];	
	}
	
	UIView *previous = nil;
	for (int index = 0; index < [_items count]; index++) {

		CGRect f = self.frame;
		f.origin.x = 0;
		f.origin.y = previous == nil ? 0.0f : previous.frame.origin.y + previous.frame.size.height;
		f.size.height = 44.0f;
		
		UIView *v;
		
		v = [_bars objectAtIndex:index];
		[v setFrame:f];
		[self addSubview:v];
		
		if ([[_items objectAtIndex:index] isEqual:open]) {
			
			//CGRect collapseFrame = _selectedItemView.frame;
			//collapseFrame.size.height = 0;
			//[_selectedItemView setFrame:collapseFrame];
			
			//[_selectedItemView removeFromSuperview];

			
			CGRect openFrame = self.frame;
			openFrame.origin.y = f.origin.y + f.size.height;
			openFrame.size.height = openFrame.size.height - (44.0f * [_items count]);

			v = _selectedItemView = newSelection;
			[_selectedItemView setFrame:openFrame];
			[self insertSubview:_selectedItemView atIndex:0];
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
