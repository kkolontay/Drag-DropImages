//
//  Images.m
//  Drag&DropImages
//
//  Created by kkolontay on 6/2/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "Images.h"

@implementation Images {
  NSArray * dataImage;
}

+ (instancetype)sharedInstance {
  static Images *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[Images alloc] init];
    [sharedInstance initData];
      });
  return sharedInstance;
}

- (NSArray *)getData {
  if (dataImage == nil ) {
    [self initData];
  }
  return dataImage;
}

- (UIImage *)getItem:(int)index {
  if (dataImage == nil) {
    [self initData];
  }
  return [dataImage objectAtIndex:index];
}

- (void)initData {
  NSArray *nameImage = [[NSArray alloc] initWithObjects:@"balloon.jpg", @"avenue.jpg", @"desert.jpg", @"still-life.jpg", @"sculpture.jpg", @"tower-bridge.jpg", @"mushroom.jpg", @"teacup.jpg", @"gorilla.jpg", nil];
  NSMutableArray* data = [[NSMutableArray alloc] init];
  for (NSString *name in nameImage) {
    [data addObject: [UIImage imageNamed: name]];
  }
  dataImage = [[NSArray alloc] initWithArray: data];
}

@end
