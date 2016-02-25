//
//  PropertyView.m
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import "PropertyView.h"

@implementation PropertyView



- (id) initWithXibName:(NSString *)xibName {
    self = [super init];
    if (self != nil) {
        self = [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] lastObject];
    }
    return self;
}

- (void) setName:(NSString *)name lastName:(NSString *)lastName {
    self.nameLabel.text = name;
    self.lastNameLabel.text = lastName;
}

@end
