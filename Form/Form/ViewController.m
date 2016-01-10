//
//  ViewController.m
//  Form
//
//  Created by guotaihan on 15/12/23.
//  Copyright © 2015年 guotaihan. All rights reserved.
//

#import "ViewController.h"
#import "FormCollectionViewCell.h"
#import "FormCollectionReusableView.h"
#import "HeadCollectionViewCell.h"
#import "Flowout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FlowoutDataSource>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Flowout *flowout = [[Flowout alloc]init];
    flowout.flowoutDataSource = self;
    
    self.collectionView.collectionViewLayout = flowout;
        
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)flowout:(Flowout *)flowout numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}


- (NSInteger)flowout:(Flowout *)flowout numberOfItemInRow:(NSInteger)row indexSection:(NSInteger)section
{
   
  
    return 4;
}



-(NSInteger)flowout:(Flowout *)flowout numbersOfColumnInRow:(NSInteger)row indexSection:(NSInteger)section
{
   
    return 4;
}

 - (CGSize)flowout:(Flowout*)flowout sizeForItemInSection:(NSInteger)section inRow:(NSInteger)row  inRowColumn:(NSInteger)rowColumn
{
    if (section == 0 && row == 0 &&rowColumn == 0) {
        
       return  CGSizeMake(3, 2);
    }
   
  return   CGSizeMake(1, 1);
}






-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    FormCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FormCollectionViewCell" forIndexPath:indexPath];
  
      cell.titlelbl.text = @"mn";
    cell.countlbl.text = [NSString stringWithFormat:@"%d",indexPath.row];
      return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    CGFloat wide = [UIScreen mainScreen].bounds.size.width/3;
    return CGSizeMake(wide, 54);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        FormCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview" forIndexPath:indexPath];
      
        headerView.backgroundColor = [UIColor redColor];
        reusableView = headerView;
       
    }
    return reusableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
