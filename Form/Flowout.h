//
//  Flowout.h
//  Form
//
//  Created by guotaihan on 16/1/9.
//  Copyright © 2016年 guotaihan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FlowoutDataSource;

@interface Flowout : UICollectionViewFlowLayout

@property(nonatomic, strong)NSMutableArray *rowDataArray;
@property(nonatomic, weak) id <FlowoutDataSource> flowoutDataSource;
@end

@protocol FlowoutDataSource<NSObject>


//设置试图有几行 row:行
- (NSInteger)flowout:(Flowout *)flowout numberOfRowsInSection:(NSInteger)section;

//一行有多少个元素

- (NSInteger)flowout:(Flowout *)flowout numberOfItemInRow:(NSInteger)row indexSection:(NSInteger)section;

//一行有多少个竖行元素 分为多少等分

-(NSInteger)flowout:(Flowout *)flowout numbersOfColumnInRow:(NSInteger)row indexSection:(NSInteger)section;

//为设置元素的大小

- (CGSize)flowout:(Flowout*)flowout sizeForItemInSection:(NSInteger)section inRow:(NSInteger)row  inRowColumn:(NSInteger)rowColumn;

@end