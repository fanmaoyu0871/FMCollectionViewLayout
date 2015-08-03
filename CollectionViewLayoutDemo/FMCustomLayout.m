//
//  FMCustomLayout.m
//  CollectionViewLayoutDemo
//
//  Created by 范茂羽 on 15/8/4.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import "FMCustomLayout.h"

@interface FMCustomLayout ()
{
    CGFloat _itemSpace;
    CGFloat _lineSpace;
    UIEdgeInsets _edgeInsets;
    CGFloat _itemHeight;
    
    NSInteger _itemCounts;
    
    CGFloat _currentX;
    CGFloat _currentY;
}

//存放布局属性的数组
@property (nonatomic, strong)NSMutableArray *attrArray;

@end

@implementation FMCustomLayout

-(NSMutableArray *)attrArray
{
    if(_attrArray == nil)
    {
        _attrArray = [NSMutableArray array];
    }
    
    return _attrArray;
}

-(instancetype)initWithItemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace edgeInsets:(UIEdgeInsets)edgeInsets itemHeight:(CGFloat)itemHeight
{
    if(self = [super init])
    {
        _itemSpace = itemSpace;
        _lineSpace = lineSpace;
        _edgeInsets = edgeInsets;
        _itemHeight = itemHeight;
        
        _currentX = _edgeInsets.left;
        _currentY = _edgeInsets.top;
        
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    [self.attrArray removeAllObjects];
    
    _itemCounts = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    
    CGRect frame = CGRectZero;
    
    
    for(NSInteger i = 0; i < _itemCounts; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        if(self.delegate)
        {
            CGFloat width = [self.delegate widthForItemAtIndexPath:indexPath];
            
            //不换行
            if(_currentX + width <= (collectionViewWidth - _edgeInsets.right))
            {
                frame = CGRectMake(_currentX, _currentY, width, _itemHeight);
            }
            //换行
            else
            {
                _currentX = _edgeInsets.left;
                _currentY += _itemHeight + _lineSpace;
                frame = CGRectMake(_currentX, _currentY, width, _itemHeight);
            }
            
            _currentX += width + _itemSpace;
        }
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = frame;
        
        [self.attrArray addObject:attr];
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrArray;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, _currentY+_itemHeight+_edgeInsets.bottom);
}






@end
