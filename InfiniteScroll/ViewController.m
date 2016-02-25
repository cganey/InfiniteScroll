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
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.announcementsScrollView.delegate = self;
    
    viewsArray = [NSMutableArray new];
    currentItemIndex = 0;
    
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
    
    self.announcementsScrollView.pagingEnabled = YES;
    

    view1 = [[PropertyView alloc] initWithXibName:@"PropertyView"];
    [view1 setName:[page9 objectForKey:@"name"] lastName:[page9 objectForKey:@"lastName"]];
    [self.announcementsScrollView addSubview:view1];
    [viewsArray addObject:view1];
    
    
    view2 = [[PropertyView alloc] initWithXibName:@"PropertyView"];
    [self.announcementsScrollView addSubview:view2];
    [view2 setName:[page1 objectForKey:@"name"] lastName:[page1 objectForKey:@"lastName"]];
     [viewsArray addObject:view2];
    
    
    view3 = [[PropertyView alloc] initWithXibName:@"PropertyView"];
    [self.announcementsScrollView addSubview:view3];
    [view3 setName:[page2 objectForKey:@"name"] lastName:[page2 objectForKey:@"lastName"]];
    [viewsArray addObject:view3];
    
}

- (void)viewDidLayoutSubviews {
    CGSize scrollViewSize = self.announcementsScrollView.frame.size;
    self.announcementsScrollView.contentSize = CGSizeMake((scrollViewSize.width*3), self.announcementsScrollView.contentSize.height);
    
    [[viewsArray objectAtIndex:0] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
    [[viewsArray objectAtIndex:1] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
    [[viewsArray objectAtIndex:2] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
    self.announcementsScrollView.contentOffset = CGPointMake(scrollViewSize.width, 0);
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGSize scrollViewSize = self.announcementsScrollView.frame.size;
    
    if (scrollView.contentOffset.x >= scrollViewSize.width*2) {
        
        if (currentItemIndex >= announcementsArray.count-1) {
            currentItemIndex = 0;
        }
        else {
            currentItemIndex++;
        }
        
        self.announcementsScrollView.contentOffset = CGPointMake(scrollViewSize.width, 0);
        
        NSLog(@"CURRENT INDEX: %i",(int)currentItemIndex);
        [[viewsArray objectAtIndex:0] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
        [[viewsArray objectAtIndex:1] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        [[viewsArray objectAtIndex:2] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
        
        PropertyView *tempView = [viewsArray objectAtIndex:0];
        [viewsArray replaceObjectAtIndex:0 withObject:[viewsArray objectAtIndex:1]];
        [viewsArray replaceObjectAtIndex:1 withObject:[viewsArray objectAtIndex:2]];
        [viewsArray replaceObjectAtIndex:2 withObject:tempView];
        
        
        if (currentItemIndex == announcementsArray.count-1) {
            NSDictionary *page = [announcementsArray firstObject];
            [tempView setName:[page objectForKey:@"name"] lastName:[page objectForKey:@"lastName"]];
        }
        else {
            NSDictionary *page = [announcementsArray objectAtIndex:currentItemIndex+1];
            [tempView setName:[page objectForKey:@"name"] lastName:[page objectForKey:@"lastName"]];
        }
        
        
        
        
        NSLog(@"current offset: %f",self.announcementsScrollView.contentOffset.x);
       
    }
    else if (scrollView.contentOffset.x <= 0) {
        if (currentItemIndex <= 0) {
            currentItemIndex = announcementsArray.count-1;
        }
        else {
         currentItemIndex--;
        }
        
        self.announcementsScrollView.contentOffset = CGPointMake(scrollViewSize.width, 0);
        
        
        NSLog(@"CURRENT INDEX: %i",(int)currentItemIndex);
        [[viewsArray objectAtIndex:2] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        [[viewsArray objectAtIndex:0] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
        [[viewsArray objectAtIndex:1] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
        
        PropertyView *tempView = [viewsArray objectAtIndex:2];
        [viewsArray replaceObjectAtIndex:2 withObject:[viewsArray objectAtIndex:1]];
        [viewsArray replaceObjectAtIndex:1 withObject:[viewsArray objectAtIndex:0]];
        [viewsArray replaceObjectAtIndex:0 withObject:tempView];
        
        if (currentItemIndex == 0) {
            NSDictionary *page = [announcementsArray lastObject];
            [tempView setName:[page objectForKey:@"name"] lastName:[page objectForKey:@"lastName"]];
        }
        else {
            NSDictionary *page = [announcementsArray objectAtIndex:currentItemIndex-1];
            [tempView setName:[page objectForKey:@"name"] lastName:[page objectForKey:@"lastName"]];
        }
        
        

    
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
