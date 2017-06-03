//
//  DragDropInstance.m
//  Drag&DropImages
//
//  Created by kkolontay on 6/2/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "DragDropInstance.h"

@implementation DragDropInstance {
  
  UIImageView *imageView;
  CGFloat width;
  CGFloat height;

}

- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseInit];
  }
  width = self.frame.size.width;
  height = self.frame.size.height;
  return self;
}

- (void) baseInit {
  imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  [self addSubview:imageView];
  [self.layer setBorderColor:[UIColor yellowColor].CGColor];
  [self.layer setBorderWidth: 3];
}

- (void)setImage: (UIImage *) image {
  imageView.image = image;
}

@end
