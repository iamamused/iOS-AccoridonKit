//
//  DemoAppDelegate.m
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

#import "DemoAppDelegate.h"
#import "DemoViewController.h"
#import "DemoTableViewController.h"

@implementation DemoAppDelegate

@synthesize window;

@synthesize viewController;
@synthesize tableViewController;

@synthesize accordionController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
	// create tab bar controller and array to hold the view controllers
	accordionController = [[AKAccordionController alloc] init];
	NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:2];
	
	[localControllersArray addObject:viewController];
	[localControllersArray addObject:tableViewController];
		
	// load up our tab bar controller with the view controllers
	accordionController.viewControllers = localControllersArray;
	
	// release the array because the tab bar controller now has it
	[localControllersArray release];
	
	// add the accordionController as a subview in the window
	[window addSubview:accordionController.view];
	
	// need this last line to display the window (and tab bar controller)
	[window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
