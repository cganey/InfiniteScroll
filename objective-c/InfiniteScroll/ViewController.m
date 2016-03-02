//
//  ViewController.m
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import "ViewController.h"
#import "PropertyView.h"
#import "AnnouncementView.h"

@interface ViewController () {
    NSMutableArray *announcementsArray;
}


@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSDictionary *page1 = @{@"title":@"Proyecto Luis 1",@"price":@"240,000",@"announcementType":@"2"};
    NSDictionary *page2 = @{@"title":@"Proyecto Arturo 2",@"price":@"330,000",@"announcementType":@"2"};
    NSDictionary *page3 = @{@"title":@"Proyecto Andrés 3",@"price":@"190,000",@"announcementType":@"2"};
    NSDictionary *page4 = @{@"title":@"Proyecto Carlos 4",@"price":@"475,000",@"announcementType":@"2"};
    NSDictionary *page5 = @{@"title":@"Aviso Juan 5",@"price":@"196,000",@"announcementType":@"1"};
    NSDictionary *page6 = @{@"title":@"Aviso José 6",@"price":@"182,000",@"announcementType":@"1"};
    NSDictionary *page7 = @{@"title":@"Proyecto Erik 7",@"price":@"604,000",@"announcementType":@"2"};
    NSDictionary *page8 = @{@"title":@"Aviso Jan 8",@"price":@"733,000",@"announcementType":@"1"};
    NSDictionary *page9 = @{@"title":@"Aviso Ricardo 9",@"price":@"255,000",@"announcementType":@"1"};
    NSDictionary *page10 = @{@"title":@"Aviso Hola 10",@"price":@"255,000",@"announcementType":@"1"};
    NSDictionary *page11 = @{@"title":@"Aviso Pulpin 11",@"price":@"255,000",@"announcementType":@"2"};
    
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
    [announcementsArray addObject:page10];
    [announcementsArray addObject:page11];
    
    
    self.announcementsScrollView.delegateISV = self;
}

- (void) viewDidLayoutSubviews {
    [self.announcementsScrollView updateLayoutFrames];
}



#pragma mark - InfiniteScrollView Delegate

- (NSInteger) numberOfElementsInInfiniteScrollView {
    return announcementsArray.count;
}

- (UIView *)infiniteScrollView:(InfiniteScrollView *)infiniteScrollView forIndex:(NSInteger)index {
    
    
    
    NSDictionary *announcementDic = [announcementsArray objectAtIndex:index];
    
    if ([[announcementDic objectForKey:@"announcementType"] isEqualToString:@"1"]) {
        AnnouncementView *announcementView = [[AnnouncementView alloc] initWithAnnouncementView:AnnouncementViewTagProperty];
        [announcementView setName:[announcementDic objectForKey:@"title"] lastName:[announcementDic objectForKey:@"price"]];
        return announcementView;
    }
    else {
        AnnouncementView *announcementView = [[AnnouncementView alloc] initWithAnnouncementView:AnnouncementViewTagProject];
        [announcementView setName:[announcementDic objectForKey:@"title"] lastName:[announcementDic objectForKey:@"price"]];
        return announcementView;
    }

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



