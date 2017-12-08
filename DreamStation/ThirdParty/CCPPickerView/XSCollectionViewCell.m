//
//  XSCollectionViewCell.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "XSCollectionViewCell.h"



@implementation XSCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.btn.titleLabel.numberOfLines = 0;
}

-(void)updateCell:(XSCollectionViewInfo *)info{
    
    [self.btn setTitle:info.title forState:UIControlStateNormal];
    if(info.isSelect==true){
        [self.btn setBackgroundImage:[UIImage imageNamed:@"Agency_Choose"] forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor colorWithRed:0.098 green:0.612 blue:0.651 alpha:1.000] forState:UIControlStateNormal];
    }else{
        [self.btn setBackgroundImage:[UIImage imageNamed:@"Agency_noChoose"] forState:UIControlStateNormal];
         [self.btn setTitleColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:UIControlStateNormal];
    }
}

- (void)updateCell2:(XSCollectionViewInfo *)info1 withInfo2:(XSCollectionViewInfo *)info2{
    
    
    
    
}

@end

@implementation XSCollectionViewInfo

@end