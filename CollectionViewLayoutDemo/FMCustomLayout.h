//
//  FMCustomLayout.h
//  CollectionViewLayoutDemo
//
//  Created by 范茂羽 on 15/8/4.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMCustomLayoutDelegate <NSObject>

-(CGFloat)widthForItemAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface FMCustomLayout : UICollectionViewLayout

-(instancetype)initWithItemSpace:(CGFloat)itemSpace lineSpace:(CGFloat)lineSpace edgeInsets:(UIEdgeInsets)edgeInsets itemHeight:(CGFloat)itemHeight;

@property (nonatomic, weak)id<FMCustomLayoutDelegate> delegate;

@end
