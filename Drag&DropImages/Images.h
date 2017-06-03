//
//  Images.h
//  Drag&DropImages
//
//  Created by kkolontay on 6/2/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Images : NSObject

+ (instancetype)sharedInstance;
- (NSArray *) getData;
- (UIImage *) getItem: (int) index;

@end
