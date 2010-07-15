//
//  AKView.h
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

#import <UIKit/UIKit.h>
#import "AccordionKit.h"
#import "AKAccordionBar.h"

@class AKAccordionItem;
@protocol AKAccordionViewDelegate;
@protocol AKAccordionBarDelegate;

@interface AKAccordionView : UIView <AKAccordionBarDelegate>{
@private
    id<AKAccordionViewDelegate>   _delegate;
    NSMutableArray        *_bars;
    NSUInteger			 _previousSelectedIndex;
    AKAccordionBar       *_selectedBar;
    UIView				  *_selectedBarView;
    struct {
        unsigned int downButtonSentAction:1;
        unsigned int isLocked:1;
    } _accordionViewFlags;
}

@property(nonatomic,assign) id<AKAccordionViewDelegate> delegate;     // weak reference. default is nil
@property(nonatomic,copy)   NSArray             *bars;        // get/set visible AKAccordionItems. default is nil. changes not animated. shown in order
@property(nonatomic,assign) AKAccordionBar       *selectedBar; // will show feedback based on mode. default is nil

- (void)setItems:(NSArray *)items animated:(BOOL)animated;   // will fade in or out or reorder and adjust spacing

@end


@protocol AKAccordionViewDelegate<NSObject>

// Section information.
- (UIView *)accordionView:(AKAccordionView *)accordionView viewForIndex:(NSUInteger)index;   // custom view for header. will be adjusted to default or specified header height

@optional

// Display customization
- (void)accordionView:(AKAccordionView *)accordionView willDisplayView:(UIView *)view forIndex:(NSUInteger)index;



// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)accordionView:(AKAccordionView *)accordionView willSelectItemAtIndex:(NSUInteger)index;
- (NSIndexPath *)accordionView:(AKAccordionView *)accordionView willDeselectItemAtIndex:(NSUInteger)index;

// Called after the user changes the selection.
- (void)accordionView:(AKAccordionView *)accordionView didSelectItemAtIndex:(NSUInteger)index;
- (void)accordionView:(AKAccordionView *)accordionView didDeselectItemAtIndex:(NSUInteger)index;


- (void)accordionView:(AKAccordionView *)accordionView didSelectItem:(AKAccordionItem *)item; // called when a new view is selected by the user (but not programatically)

@end