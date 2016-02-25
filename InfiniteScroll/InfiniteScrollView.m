//
//  InfiniteScrollView.m
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import "InfiniteScrollView.h"


@implementation InfiniteScrollView {
    NSInteger currentItemIndex;
}

@synthesize delegateISV = _delegateISV;



- (id)initWithCoder:(NSCoder*)coder { // Loaded from Nib
    if ((self = [super initWithCoder:coder])) {
        [self configScrollViewViews];
    }
    return self;
}


- (void) configScrollViewViews {
    self.delegate = self;
    self.viewsArray = [NSMutableArray new];
    self.pagingEnabled = YES;
    currentItemIndex = 0;
}


- (void)setDelegateISV:(id<InfiniteScrollViewDelegate>)delegateISV {
    _delegateISV = delegateISV;
    [self callFirstInitDelegateMethod];
    
}

- (void) callFirstInitDelegateMethod {
    self.numberOfElements = [self.delegateISV numberOfElementsInInfiniteScrollView];
    
    for (int i=0; i<3; i++) {
        UIView *view = [self.delegateISV infiniteScrollView:self withInitialViewPosition:i];
        switch (i) {
            case 0:     [self.delegateISV infiniteScrollView:self updateView:view forIndex:self.numberOfElements-1];    break;
            case 1:     [self.delegateISV infiniteScrollView:self updateView:view forIndex:0];                          break;
            case 2:     [self.delegateISV infiniteScrollView:self updateView:view forIndex:1];                          break;
            default:
                break;
        }
        
        [self addSubview:view];
        [self.viewsArray addObject:view];
    }
    
}

- (void) updateLayoutFrames {
    CGSize scrollViewSize = self.frame.size;
    self.contentSize = CGSizeMake((scrollViewSize.width*3), self.contentSize.height);
    [[self.viewsArray objectAtIndex:0] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
    [[self.viewsArray objectAtIndex:1] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
    [[self.viewsArray objectAtIndex:2] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
    self.contentOffset = CGPointMake(self.frame.size.width, 0);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGSize scrollViewSize = self.frame.size;
    
    if (scrollView.contentOffset.x >= scrollViewSize.width*2) {
        
        if (currentItemIndex >= self.numberOfElements-1) {
            currentItemIndex = 0;
        }
        else {
            currentItemIndex++;
        }
        
        self.contentOffset = CGPointMake(scrollViewSize.width, 0);
        
        //NSLog(@"CURRENT INDEX: %i",(int)currentItemIndex);
        [[self.viewsArray objectAtIndex:0] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
        [[self.viewsArray objectAtIndex:1] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        [[self.viewsArray objectAtIndex:2] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
        
        UIView *tempView = [self.viewsArray objectAtIndex:0];
        [self.viewsArray replaceObjectAtIndex:0 withObject:[self.viewsArray objectAtIndex:1]];
        [self.viewsArray replaceObjectAtIndex:1 withObject:[self.viewsArray objectAtIndex:2]];
        [self.viewsArray replaceObjectAtIndex:2 withObject:tempView];
        
        
        if (currentItemIndex == self.numberOfElements-1) {
            [self.delegateISV infiniteScrollView:self updateView:tempView forIndex:0];
        }
        else {
            [self.delegateISV infiniteScrollView:self updateView:tempView forIndex:currentItemIndex+1];
        }
        
        
    }
    else if (scrollView.contentOffset.x <= 0) {
        if (currentItemIndex <= 0) {
            currentItemIndex = self.numberOfElements-1;
        }
        else {
            currentItemIndex--;
        }
        
        self.contentOffset = CGPointMake(scrollViewSize.width, 0);
        
        
        //NSLog(@"CURRENT INDEX: %i",(int)currentItemIndex);
        [[self.viewsArray objectAtIndex:2] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        [[self.viewsArray objectAtIndex:0] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
        [[self.viewsArray objectAtIndex:1] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
        
        UIView *tempView = [self.viewsArray objectAtIndex:2];
        [self.viewsArray replaceObjectAtIndex:2 withObject:[self.viewsArray objectAtIndex:1]];
        [self.viewsArray replaceObjectAtIndex:1 withObject:[self.viewsArray objectAtIndex:0]];
        [self.viewsArray replaceObjectAtIndex:0 withObject:tempView];
        
        if (currentItemIndex == 0) {
            [self.delegateISV infiniteScrollView:self updateView:tempView forIndex:self.numberOfElements-1];
        }
        else {
            [self.delegateISV infiniteScrollView:self updateView:tempView forIndex:currentItemIndex-1];
        }
        
    }
    
    
}


@end
