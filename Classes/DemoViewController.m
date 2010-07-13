//
//  DemoViewController.m
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

#import "DemoViewController.h"
#import <AccordionKit/AccordionKit.h>

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Accordion View 1";
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark AKAccordionControllerDelegate

- (AKAccordionItem *)accordionItem;
{
	NSLog(@"accordionItem");
	return [[[AKAccordionItem alloc] initWithTitle:@"Touch me to expand/collapse" image:[UIImage imageNamed:@"icon.png"] tag:0] autorelease];
}

- (BOOL)accordionController:(AKAccordionController *)accordionController shouldSelectViewController:(UIViewController *)viewController;
{
	NSLog(@"accordionController:shouldSelectViewController");
	return YES;
}

- (void)accordionController:(AKAccordionController *)accordionController didSelectViewController:(UIViewController *)viewController;
{
	NSLog(@"accordionController:didSelectViewController");
}

// Before and after expansion
- (void)accordionController:(AKAccordionController *)accordionController willExpandViewController:(UIViewController *)viewController;
{
	NSLog(@"accordionController:willExpandViewController");
}

- (void)accordionController:(AKAccordionController *)accordionController didExpandViewController:(UIViewController *)viewController;
{
	NSLog(@"accordionController:didExpandViewController");
}


// Before and after collapse
- (void)accordionController:(AKAccordionController *)accordionController willCollapseViewController:(UIViewController *)viewController;
{
	NSLog(@"accordionController:willCollapseViewController");
}

- (void)accordionController:(AKAccordionController *)accordionController didCollapseViewController:(UIViewController *)viewController;
{
	NSLog(@"accordionController:didCollapseViewController");
}



@end
