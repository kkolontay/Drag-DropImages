//
//  SourceCollectionViewCell.m
//  Drag&DropImages
//
//  Created by kkolontay on 6/2/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "SourceCollectionViewCell.h"

@interface SourceCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SourceCollectionViewCell

- (void) setImage: (UIImage *) image {
  self.imageView.image = image;
}

- (void) cleraImage {
  _imageView.image = nil;
}

- (void)setHighlighted:(BOOL)highlighted {
  if (highlighted) {
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 4.0f;
  } else {
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth  = 1.0f;
  }
}

- (UIImage *)getImage {
  return self.imageView.image;
}

@end
