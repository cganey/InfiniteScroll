//
//  ViewController.h
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteScrollView.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet InfiniteScrollView *announcementsScrollView;


@end

