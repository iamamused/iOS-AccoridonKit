//
//  AKAccordionController.m
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


@implementation AKAccordionController

@synthesize selectedViewController = _selectedViewController;
@synthesize accordion = _accordion;
@synthesize delegate = _delegate;
@synthesize viewControllers = _viewControllers;


/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
// Custom initialization
}
return self;
}
*/


- (void)loadView {
	
	NSMutableArray *items = [NSMutableArray arrayWithCapacity:[_viewControllers count]];
	
	for (UIViewController *c in _viewControllers) {
		if ([c accordionItem] != nil) {	
			[items addObject:[c accordionItem]];
			continue;
		}
		
		// Create a new item based on view controller title;
		[c loadView]; // so everything is ready.
		[c viewDidLoad]; // call viewDidLoad since we just loaded it
		AKAccordionItem *ai = [[AKAccordionItem alloc] initWithTitle:c.title image:[UIImage imageNamed:@"icon.png"] tag:nil];
		[items addObject:ai];
		[ai release];
		
	}
	
	
	UIScreen *screen = [UIScreen mainScreen];
	// AKAccordionView will resize to fit parent view as necessary.
	AKAccordionView *a = [[AKAccordionView alloc] initWithFrame:[screen applicationFrame]];
	[a setDelegate:self];
	[a setItems:items]; 
	
	self.view = a;
}

- (void)setViewControllers:(NSArray *)viewControllers;
{
	// setup the view controllers.
	[_viewControllers release];
	_viewControllers = nil;
	_viewControllers = [viewControllers retain];
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
{
	[self setViewControllers:viewControllers];
}

- (NSUInteger)selectedIndex {
	return [_viewControllers indexOfObject:self.selectedViewController];
}

- (void)selectedIndex:(NSUInteger)index {
	[self setSelectedViewController:[_viewControllers objectAtIndex:index]];
}

#pragma mark -
#pragma mark AKAccordionViewDelegate

- (UIView *)accordionView:(AKAccordionView *)accordionView viewForIndex:(NSUInteger)index;
{
	UIViewController *c = [_viewControllers objectAtIndex:index];
	return [c view];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_viewControllers release];
   [super dealloc];
}


@end


@implementation UIViewController (AKAccordionControllerItem)

- (AKAccordionItem *)accordionItem;
{
	return nil;
}

@end


