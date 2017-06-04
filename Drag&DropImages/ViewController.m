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

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, CollectionViewDidChangeSize>

@property (weak, nonatomic) IBOutlet ViewCollectivon *collection;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *sourceCollectionView;
@property NSMutableArray *data;
@property DragDropInstance *dragView;

@end

@implementation ViewController {
  SourceCollectionViewCell *choosenCell;
}

- (void)viewDidLoad {
  [super viewDidLoad];
   _data = [[NSMutableArray alloc] initWithArray:[[Images sharedInstance] getData]];
  _collection.delegate = self;
    [_sourceCollectionView reloadData];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
   [_collection setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  CGPoint point = [self getPoint:event];
  if (choosenCell != nil) {
  [self setFrameDragItem:point];
  }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  CGPoint point = [self getPoint:event];
  [self setFrameDragItem:point];
  BOOL isInside = CGRectContainsPoint(_scrollView.frame, point);
  if (isInside == YES) {
    _collection.layer.borderColor = [UIColor yellowColor].CGColor;
    _collection.layer.borderWidth = 3;
  } else {
    _collection.layer.borderColor = [UIColor clearColor].CGColor;
  }
 }

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  CGPoint point = [self getPoint:event];
  [_dragView removeFromSuperview];
  BOOL isInside = CGRectContainsPoint(_scrollView.frame, point);
  if (isInside == YES) {
    [_collection addImage:[_data objectAtIndex: choosenCell.indexImage]];
  }
  _collection.layer.borderColor = [UIColor clearColor].CGColor;
  _dragView = nil;
  choosenCell = nil;
}

- (CGPoint)getPoint: (UIEvent *) event {
  UITouch *touch = [[event allTouches] allObjects].firstObject;
  return  [touch locationInView:self.view];
}

- (void)setFrameDragItem:(CGPoint) point {
  CGFloat deltaX = _dragView.frame.size.height / 2;
  [_dragView setFrame:CGRectMake(point.x -  deltaX, point.y - deltaX, deltaX * 2, deltaX * 2)];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  choosenCell = (SourceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  if (choosenCell != nil) {
    if (_dragView != nil) {
      [_dragView removeFromSuperview];
      _dragView = nil;
    }
    _dragView = [[DragDropInstance alloc] initWithFrame:choosenCell.frame];
    [_dragView setImage:[_data objectAtIndex:choosenCell.indexImage]];
    [self.view addSubview:_dragView];
    [self.view bringSubviewToFront:_dragView];
  }
  return YES;
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
