//
//  ViewCollectivon.m
//  Drag&DropImages
//
//  Created by kkolontay on 6/3/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "ViewCollectivon.h"

const CGFloat distanceBetweenImageView = 5;

@implementation ViewCollectivon {
  NSMutableArray *imageViews;
 
}

- (void)drawRect:(CGRect)rect {
  [self setSizeView:rect];
  [self removeAllViewFromSelf];
  [self setImages];
}

- (void)setSizeView:(CGRect)rect {
  if (rect.size.height != ((UIImageView *)imageViews.firstObject).image.size.height) {
    CGFloat rate = rect.size.height / ((UIImageView *)imageViews.firstObject).frame.size.height;
    for (UIImageView * item in imageViews) {
      [item setFrame:CGRectMake(0, 0, item.frame.size.width * rate, item.frame.size.height * rate)];
    }
  }
}

- (void) setImages {
  CGFloat totalWidtch = 0;
  UIImageView *preView = nil;
  for (UIImageView *item in imageViews) {
    [self addSubview: item];
    totalWidtch += distanceBetweenImageView;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeLeft multiplier:1 constant:totalWidtch];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:item.frame.size.height];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1 constant:item.frame.size.width];
    totalWidtch += item.frame.size.width;
    [self addConstraints:@[left, top]];
    [item addConstraints:@[height, width]];
    preView = item;
    [self layoutIfNeeded];
    [item layoutIfNeeded];
  }
  preView = nil;
  totalWidtch += distanceBetweenImageView;
  if( totalWidtch > self.frame.size.width) {
  [self setFrame:CGRectMake(0, 0, totalWidtch, self.frame.size.height)];
    [_delegate sizeCnaged:self.frame.size];
  }
}

- (CGRect)getRect:(UIImage *) image {
  CGFloat widthImage = image.size.width;
  CGFloat heightImage = image.size.height;
  CGFloat height = self.frame.size.height;
  CGFloat rate = height / heightImage;
  return  CGRectMake(0, 0, widthImage * rate, heightImage * rate);
}

- (void)removeAllViewFromSelf {
  for (UIImageView *item in imageViews) {
    for (NSLayoutConstraint *constraint in item.constraints) {
      [item removeConstraint:constraint];
    }
    [item removeFromSuperview];
  }
}

- (void)addImage:(UIImage *) image {
  if (imageViews == nil) {
    imageViews = [[NSMutableArray alloc] init];
  }
  UIImageView *imageView = [[UIImageView alloc ] initWithFrame:[self getRect:image]];
  imageView.image = image;
  [imageView setContentMode:UIViewContentModeScaleAspectFit];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [imageViews addObject:imageView];
  [self setNeedsDisplay];
}

@end
