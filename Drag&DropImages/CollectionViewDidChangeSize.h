//
//  CollectionViewDidChangeSize.h
//  Drag&DropImages
//
//  Created by kkolontay on 6/3/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CollectionViewDidChangeSize <NSObject>

- (void)sizeCnaged:(CGSize)size;

@end
