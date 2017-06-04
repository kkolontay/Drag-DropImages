//
//  ViewController.m
//  Drag&DropImages
//
//  Created by kkolontay on 6/2/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "ViewController.h"
#import "Images.h"
#import "SourceCollectionViewCell.h"
#import "DragDropInstance.h"
#import "ViewCollectivon.h"
#import "CollectionViewDidChangeSize.h"

const CGFloat distanceBetweenCell = 5.0f;

@interface ViewController () <UICollectionViewDataSource, UIGestureRecognizerDelegate, CollectionViewDidChangeSize>

@property (weak, nonatomic) IBOutlet ViewCollectivon *collection;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *sourceCollectionView;
@property NSMutableArray *data;
@property DragDropInstance *dragView;

@end

@implementation ViewController {
  SourceCollectionViewCell *choosenCell;
  UILongPressGestureRecognizer *longPressGesture;
  int indexSelected;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
  longPressGesture.delegate = self;
  [_sourceCollectionView addGestureRecognizer:longPressGesture];
  longPressGesture.minimumPressDuration = 0.2;
  _data = [[NSMutableArray alloc] initWithArray:[[Images sharedInstance] getData]];
  _collection.delegate = self;
  [_sourceCollectionView reloadData];
}

- (void)handleLongPress: (UILongPressGestureRecognizer *) recognizer {
  CGPoint point = [recognizer locationInView: _sourceCollectionView];
  
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
      indexSelected = (int) [_sourceCollectionView indexPathForItemAtPoint:point].row;
      choosenCell = (SourceCollectionViewCell *)[_sourceCollectionView cellForItemAtIndexPath:[_sourceCollectionView indexPathForItemAtPoint:point]];
      _dragView = [[DragDropInstance alloc] initWithFrame:choosenCell.frame];
      [_dragView setImage:[_data objectAtIndex:indexSelected]];
      [self.view addSubview:_dragView];
      [self.view bringSubviewToFront:_dragView];
      [self setFrameDragItem:point];
      NSLog(@"began");
      break;
    case UIGestureRecognizerStateChanged:
      [self setFrameDragItem:point];
        BOOL isInside = CGRectContainsPoint(_scrollView.frame, point);
        if (isInside == YES) {
          _collection.layer.borderColor = [UIColor yellowColor].CGColor;
        _collection.layer.borderWidth = 3;
        } else {
          _collection.layer.borderColor = [UIColor clearColor].CGColor;
        }
      NSLog(@"changed");
      break;
    case UIGestureRecognizerStateEnded:
      [_dragView removeFromSuperview];
        BOOL isInsideView = CGRectContainsPoint(_scrollView.frame, point);
        if (isInsideView == YES) {
          [_collection addImage:[_data objectAtIndex: choosenCell.indexImage]];
       }
       _collection.layer.borderColor = [UIColor clearColor].CGColor;
        _dragView = nil;
        choosenCell = nil;
      NSLog(@"end");
      break;
    default:
      break;
  }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [_collection setNeedsDisplay];
}

- (void)setFrameDragItem:(CGPoint) point {
  CGFloat deltaX = _dragView.frame.size.height / 2;
  [_dragView setFrame:CGRectMake(point.x -  deltaX, point.y - deltaX, deltaX * 2, deltaX * 2)];
}

- (void)sizeCnaged:(CGSize)size {
  [_scrollView setContentSize: size];
  [_scrollView setNeedsDisplay];
}

-  (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  SourceCollectionViewCell *cell = (SourceCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSource" forIndexPath:indexPath];
  cell.indexImage = (int) indexPath.row;
  [cell setImage:[_data objectAtIndex: indexPath.row]];
  
  return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return distanceBetweenCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  int countInRow = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 4: 3;
  int width = [UIScreen mainScreen].bounds.size.width;
  int widtchCell = floor((width - (countInRow + 1) * distanceBetweenCell) / countInRow);
  return CGSizeMake(widtchCell, widtchCell);
}

@end
