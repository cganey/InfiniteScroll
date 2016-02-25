//
//  PropertyView.h
//  InfiniteScroll
//
//  Created by Luis Perez on 22/02/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

- (id) initWithXibName:(NSString *)xibName;

- (void) setName:(NSString *)name lastName:(NSString *)lastName;

@end
