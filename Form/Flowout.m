//
//  Flowout.m
//  Form
//
//  Created by guotaihan on 16/1/9.
//  Copyright © 2016年 guotaihan. All rights reserved.
//

#import "Flowout.h"

static NSInteger itemHeight = 60;

@interface Flowout()
{
     NSMutableArray *attributesArray;
    NSMutableArray *rowPointArray; //保存当前row的位置
     NSInteger currentRow;
    CGRect agoRect;
    NSInteger minHeight;  //表格高度最小
    NSInteger maxWide;  //最大宽度
}
@end
@implementation Flowout

-(void)prepareLayout
{
    attributesArray = [[NSMutableArray alloc]initWithCapacity:0];
    
   
    rowPointArray =[[NSMutableArray alloc]initWithCapacity:0];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [self layoutAttributesData];
    for (int i = 0; i < rowPointArray.count ;i++ ) {
        
        CGRect rect = [[rowPointArray objectAtIndex:i]CGRectValue];
        NSString *str = NSStringFromCGRect(rect);
        NSLog(@"%@",str);
    }
    return attributesArray;
    
  }

- (void)layoutAttributesData
{

    NSInteger sectionCount = self.collectionView.numberOfSections;
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        
        //section下有多少行
        NSInteger rowCount = 0;
        if ([_flowoutDataSource respondsToSelector:@selector(flowout:numberOfRowsInSection:)]) {
            rowCount = [_flowoutDataSource flowout:self numberOfRowsInSection:section];
        }
      
        for (NSInteger row = 0; row < rowCount; row++) {
            //每一行有多少列
            NSInteger coloumCount = 0;
            if ([_flowoutDataSource respondsToSelector:@selector(flowout:numberOfItemInRow:indexSection:)]) {
             
                coloumCount = [_flowoutDataSource flowout:self numberOfItemInRow:row indexSection:section];
            }
           
            
            
            for (NSInteger column = 0; column < coloumCount; column++) {
                
                NSInteger index = row * coloumCount + column;
                
                NSIndexPath *indexPath =[NSIndexPath indexPathForItem:index inSection:section];
                
                CGSize currentSize = CGSizeMake(1, 1);
              
                if ([_flowoutDataSource respondsToSelector:@selector(flowout:sizeForItemInSection:inRow:inRowColumn:)]) {
                    currentSize = [_flowoutDataSource flowout:self sizeForItemInSection:section inRow:row inRowColumn:column];
                }
                UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                //竖行元素
                
                NSInteger verticalcount = 0;
                
                if([_flowoutDataSource respondsToSelector:@selector(flowout:numbersOfColumnInRow:indexSection:)])
                {
                    //竖行等份比例
                    verticalcount = [_flowoutDataSource flowout:self numbersOfColumnInRow:row indexSection:section];
                }
                
              
                
                    //取的当前row一个item的坐标
                    CGRect agosize = [[rowPointArray lastObject]CGRectValue];
                    //相对于self 当前的wide
                    NSInteger width = agosize.origin.x + agosize.size.width;
                    //如果当前的wide大于等于self的尺寸 证明wide还可以放元素
                
                
                
                    if (width < self.collectionView.bounds.size.width) {
                     
                        CGFloat orx = agosize.size.width + agosize.origin.x;
                        CGFloat ory = agosize.origin.y;
                        
                        NSLog(@"---%f",orx);
                        
                        currentSize = [self itemSize:currentSize row:row column:column rowColumnCount:verticalcount lineWide:orx];
                        
                        [layoutAttributes setFrame:CGRectMake(orx, ory, currentSize.width,currentSize.height)];
                        
                        if (indexPath.row == 0) {
                              minHeight = layoutAttributes.frame.origin.y + layoutAttributes.size.height;
                        }
                        
                    }else{
                        //需要换行  必须有一个item的高度最大 不然就可以直接处理啦
                        //minRect 代表上一个表格从左到右高度最低的

                        CGRect minRect;
                        for (NSInteger insert = 0; insert < rowPointArray.count; insert++) {
                             minRect = [[rowPointArray objectAtIndex:insert]CGRectValue];
                            if (minRect.origin.y + minRect.size.height == minHeight) {
                                break;
                            }
                        }
                       
                        CGFloat orx = minRect.origin.x;
                        CGFloat ory = minRect.origin.y + minRect.size.height;
                        
                           NSLog(@"++++%f",orx);
                        currentSize = [self itemSize:currentSize row:row column:column rowColumnCount:verticalcount lineWide:orx];
                        
                        [layoutAttributes setFrame:CGRectMake(orx, ory, currentSize.width,currentSize.height)];
                        
                       
                      
                        minHeight = layoutAttributes.frame.origin.y + layoutAttributes.size.height;
                      
                        //[rowPointArray removeAllObjects];
                        
                    
                        
                    }
                    
                
                if (minHeight > layoutAttributes.frame.origin.y + layoutAttributes.size.height) {
                    minHeight = layoutAttributes.frame.origin.y + layoutAttributes.size.height;
                }
                
                [attributesArray addObject:layoutAttributes];
                //方便取的前一个坐标
                [rowPointArray addObject:[NSValue valueWithCGRect:layoutAttributes.frame]];
            }
            
        }
        
    }
    
}

//row:第几行  column:第几行第几个item  columnCount： row 里有共多少等分
- (CGSize)itemSize:(CGSize)itemSize row:(NSInteger)row column:(NSInteger)column rowColumnCount:(NSInteger)columnCount lineWide:(NSInteger)wideline
{
    NSInteger averageWide = floorf(self.collectionView.bounds.size.width/columnCount);
    
     maxWide = self.collectionView.bounds.size.width - (averageWide*(columnCount -1));
    if (wideline < maxWide) {
        
        //最大wide
        NSInteger totalWide = (itemSize.width - 1) * averageWide + maxWide;
        NSInteger totalHeight = itemSize.height * itemHeight;
        return CGSizeMake(totalWide, totalHeight);

    }else{
        NSInteger totalWide = itemSize.width * averageWide;
        NSInteger totalHeight = itemSize.height * itemHeight;
        return CGSizeMake(totalWide, totalHeight);
    }
    
}



@end
