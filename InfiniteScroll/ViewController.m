//
//  ViewController.m
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import "ViewController.h"
#import "PropertyView.h"

@interface ViewController () {
    PropertyView *view1;
    PropertyView *view2;
    PropertyView *view3;
    NSMutableArray *viewsArray;
    NSMutableArray *announcementsArray;
    NSInteger currentItemIndex;
    NSInteger itemCount;
}


@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSDictionary *page1 = @{@"name":@"Luis",@"lastName":@"Perez"};
    NSDictionary *page2 = @{@"name":@"Arturo",@"lastName":@"Ramirez"};
    NSDictionary *page3 = @{@"name":@"Andrés",@"lastName":@"Sánchez"};
    NSDictionary *page4 = @{@"name":@"Carlos",@"lastName":@"Flores"};
    NSDictionary *page5 = @{@"name":@"Juan",@"lastName":@"Bravo"};
    NSDictionary *page6 = @{@"name":@"José",@"lastName":@"Granados"};
    NSDictionary *page7 = @{@"name":@"Erik",@"lastName":@"Vargas"};
    NSDictionary *page8 = @{@"name":@"Jan",@"lastName":@"Herrera"};
    NSDictionary *page9 = @{@"name":@"Ricardo",@"lastName":@"Rojas"};
    
    announcementsArray = [NSMutableArray new];
    [announcementsArray addObject:page1];
    [announcementsArray addObject:page2];
    [announcementsArray addObject:page3];
    [announcementsArray addObject:page4];
    [announcementsArray addObject:page5];
    [announcementsArray addObject:page6];
    [announcementsArray addObject:page7];
    [announcementsArray addObject:page8];
    [announcementsArray addObject:page9];
    
    self.announcementsScrollView.delegateISV = self;
    
}

- (void) viewDidLayoutSubviews {
    [self.announcementsScrollView updateLayoutFrames];
    
}



#pragma mark - InfiniteScrollView Delegate

- (NSInteger) numberOfElementsInInfiniteScrollView {
    return announcementsArray.count;
}

- (void)infiniteScrollView:(InfiniteScrollView *)infiniteScrollView updateView:(id)view forIndex:(NSInteger)index {
    PropertyView *propertyView = (PropertyView *)view;
    NSDictionary *page = [announcementsArray objectAtIndex:index];
    [propertyView setName:[page objectForKey:@"name"] lastName:[page objectForKey:@"lastName"]];
    
}



- (UIView *)infiniteScrollView:(InfiniteScrollView *)infiniteScrollView withInitialViewPosition:(InfiniteScrollViewViewPosition)viewPosition {
    
    switch (viewPosition) {
        case InfiniteScrollViewViewPositionHiddenLeft:
            return [[PropertyView alloc] initWithXibName:@"PropertyView"];
            break;
        case InfiniteScrollViewViewPositionVisible:
            return [[PropertyView alloc] initWithXibName:@"PropertyView"];
            break;
        case InfiniteScrollViewViewPositionHiddenRight:
            return [[PropertyView alloc] initWithXibName:@"PropertyView"];
            break;
            
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



