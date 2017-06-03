//
//  ViewCollectivon.h
//  Drag&DropImages
//
//  Created by kkolontay on 6/3/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewDidChangeSize.h"

@interface ViewCollectivon : UIView

@property(weak, nonatomic) id <CollectionViewDidChangeSize> delegate;

- (void)addImage:(UIImage *)image;

@end
