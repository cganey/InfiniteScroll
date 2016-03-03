//
//  AnnouncementView.m
//  InfiniteScroll
//
//  Created by Luis Perez on 26/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import "AnnouncementView.h"

@implementation AnnouncementView

- (id) initWithAnnouncementView:(AnnouncementViewTag)announcementViewTag {
    self = [super init];
    if (self != nil) {
        int viewIndex = 0;
        switch (announcementViewTag) {
            case AnnouncementViewTagProperty:       viewIndex = 0;      break;
            case AnnouncementViewTagProject:        viewIndex = 1;      break;
            default:                                                    break;
        }
        NSLog(@"LOAD WITH INDEX: %i",viewIndex);
        self = [[[NSBundle mainBundle] loadNibNamed:@"PropertyView" owner:self options:nil] objectAtIndex:viewIndex];
        
    }
    return self;
}

- (void) setName:(NSString *)name lastName:(NSString *)lastName {
    self.nameLabel.text = name;
    self.lastNameLabel.text = lastName;
}

- (void)updateViewFor:(AnnouncementViewTag )announcementViewTag {
    int viewIndex = 0;
    switch (announcementViewTag) {
        case AnnouncementViewTagProperty:       viewIndex = 0;      break;
        case AnnouncementViewTagProject:        viewIndex = 1;      break;
        default:                                                    break;
    }
    NSLog(@"INDEX VIEW TO LOAD: %i",viewIndex);
    
    
    
}




@end
