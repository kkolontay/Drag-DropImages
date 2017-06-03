//
//  SourceCollectionViewCell.h
//  Drag&DropImages
//
//  Created by kkolontay on 6/2/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SourceCollectionViewCell : UICollectionViewCell

@property int indexImage;

- (void) setImage: (UIImage *) image;
- (void) cleraImage;
- (UIImage *)getImage;

@end
