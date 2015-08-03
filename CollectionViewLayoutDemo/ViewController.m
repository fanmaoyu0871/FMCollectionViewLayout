//
//  ViewController.m
//  CollectionViewLayoutDemo
//
//  Created by 范茂羽 on 15/8/4.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import "ViewController.h"
#import "FMCustomLayout.h"

#define CELLID @"cellID"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, FMCustomLayoutDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createData];
    
    [self createCollectionView];
}

-(void)createData
{
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(NSInteger i = 0; i < 50; i++)
    {
        NSNumber *width = [NSNumber numberWithFloat:arc4random_uniform(100)/1.0];
        [self.dataArray addObject:width];
    }
}

-(void)createCollectionView
{
    FMCustomLayout *layout = [[FMCustomLayout alloc]initWithItemSpace:10 lineSpace:20 edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10) itemHeight:50];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELLID];
}

#pragma mark - FMCustomLayoutDelegate
-(CGFloat)widthForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.item]floatValue];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
