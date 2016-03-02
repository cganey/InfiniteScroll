//
//  InfiniteScrollView.h
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    InfiniteScrollViewViewPositionHiddenLeft = 0,
    InfiniteScrollViewViewPositionVisible = 1,
    InfiniteScrollViewViewPositionHiddenRight = 2
} InfiniteScrollViewViewPosition;


@class InfiniteScrollView;


@protocol InfiniteScrollViewDelegate <NSObject>
- (NSInteger) numberOfElementsInInfiniteScrollView;
- (UIView *) infiniteScrollView :(InfiniteScrollView *)infiniteScrollView forIndex:(NSInteger)index;
@end


@interface InfiniteScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) id <InfiniteScrollViewDelegate> delegateISV;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) NSMutableArray *viewsArray;
@property (nonatomic) NSInteger numberOfElements;

- (void) updateLayoutFrames;

@end

