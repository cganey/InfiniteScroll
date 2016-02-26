//
//  AnnouncementView.h
//  InfiniteScroll
//
//  Created by Luis Perez on 26/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    AnnouncementViewTagProperty = 0,
    AnnouncementViewTagProject = 1
} AnnouncementViewTag;

@interface AnnouncementView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;


- (id) initWithAnnouncementView:(AnnouncementViewTag)announcementViewTag;
- (void) setName:(NSString *)name lastName:(NSString *)lastName;
- (void) updateViewFor:(AnnouncementViewTag)announcementViewTag;

@end
