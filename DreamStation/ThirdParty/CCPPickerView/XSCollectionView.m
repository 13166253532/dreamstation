//
//  XSCollectionView.m
//  CCPPickerDemo
//
//  Created by 刘佳斌 on 16/8/4.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import "XSCollectionView.h"
#import "UIAlertView+XDExtension.h"
#import "XSCollectionViewCell.h"

#define XSWIDTH [UIScreen mainScreen].bounds.size.width
#define XSHEIGHT [UIScreen mainScreen].bounds.size.height

@interface XSCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

typedef NS_ENUM(NSInteger,CollectionType){

    AreasOfConcern = 0,
    InvestmentStage = 1,
    RegionalInvestment = 2,
    Currencies = 3
    
};

@property (strong, nonatomic) NSMutableArray *dateArray;

@property (nonatomic,strong)UICollectionView *XSCollectionView;
@property (nonatomic,strong)UIToolbar *toolBar;
@property (nonatomic,strong)UIView *containerView;

@property (copy,nonatomic)NSString *titleString;
@property (copy,nonatomic)NSString *leftString;
@property (copy,nonatomic)NSString *rightString;
@property (copy,nonatomic)NSMutableArray *dataList;
@property (assign,nonatomic)NSInteger numType;

@property (assign,nonatomic)CGFloat CollectHeight;
@property (copy,nonatomic)NSArray *selectedArray;


@property (assign,nonatomic)CGSize cellSize;


@end

@implementation XSCollectionView

- (NSMutableArray *)dateArray {
    
    if (_dateArray == nil) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


- (UICollectionView*)XSCollectionView{

    if (_XSCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
      
        _XSCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, XSWIDTH, 246) collectionViewLayout:flowLayout];
        [_XSCollectionView registerNib:[UINib nibWithNibName:@"XSCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XSCollectionViewCell"];
        
        _XSCollectionView.delegate = self;
        _XSCollectionView.dataSource = self;
        _XSCollectionView.backgroundColor = [UIColor whiteColor];

    }
    return _XSCollectionView;
}

- (UIToolbar *)toolBar{

    if (_toolBar == nil) {
        _toolBar = [self setToolbarStyle:self.titleString andCancel:self.leftString andSure:self.rightString];
       
    }
    return _toolBar;
}

- (UIToolbar *)setToolbarStyle:(NSString *)titleString andCancel:(NSString *)cancelString andSure:(NSString *)sureString{
    
    NSLog(@"%f",XSWIDTH);
    
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, XSWIDTH, 40);
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XSWIDTH , 40)];
    lable.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000]
    ;
    lable.text = titleString;
    lable.textAlignment = 1;
    lable.textColor = [UIColor blackColor];
    lable.numberOfLines = 1;
    lable.font = [UIFont systemFontOfSize:18];
    [toolbar addSubview:lable];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.frame = CGRectMake(0, 5, 40, 35);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn setTitleColor:[UIColor colorWithWhite:0.400 alpha:1.000] forState:UIControlStateNormal];
    [cancelBtn setTitle:cancelString forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor = [UIColor clearColor];
    chooseBtn.frame = CGRectMake(0, 5, 40, 35);
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [chooseBtn setTitleColor:[UIColor colorWithRed:0.098 green:0.612 blue:0.651 alpha:1.000] forState:UIControlStateNormal];
    [chooseBtn setTitle:sureString forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(doneItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    centerSpace.width = 70;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:chooseBtn];
    
    toolbar.items=@[leftItem,centerSpace,rightItem];

    
    return toolbar;
}


- (UIView *)containerView {
    
    if (_containerView == nil) {
 
        [self setChoose];
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, XSHEIGHT - 286, XSWIDTH, 286)];
        _containerView.backgroundColor = [UIColor clearColor];
        
        [_containerView addSubview:self.toolBar];
        [_containerView addSubview:self.XSCollectionView];
        
        
    }
    return _containerView;
}

- (instancetype)initWithCollectionViewWithCenterTitle:(NSString *)title andCancel:(NSString *)cancel andSure:(NSString *)sure andData:(NSArray *)data andType:(int)type{
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.titleString = title;
        self.leftString = cancel;
        self.rightString = sure;
        for(int i=0;i<data.count;i++){
            XSCollectionViewInfo *info=[[XSCollectionViewInfo alloc]init];
            info.title=data[i];
            [self.dataList addObject:info];
        }
        self.numType = type;
        [self addSubview:self.containerView];
        UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        [currentWindows addSubview:self];
        
    }
    return self;
}

- (instancetype)initWithCollectionViewWithCenterTitle:(NSString *)title andCancel:(NSString *)cancel andSure:(NSString *)sure andData:(NSArray *)data andType:(int)type andSelectedList:(NSArray *)selectedList{
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.titleString = title;
        self.leftString = cancel;
        self.rightString = sure;
        for(int i=0;i<data.count;i++){
            XSCollectionViewInfo *info=[[XSCollectionViewInfo alloc]init];
            info.title=data[i];
            //for遍历，判断是否已经有选中的选项，有则选中状态为YES
            for (int j = 0; j<selectedList.count; j++) {
                if ([info.title isEqualToString:selectedList[j]]) {
                    info.isSelect = YES;
                    [self.dateArray addObject:info.title];
                }
            }
            [self.dataList addObject:info];
        }
        self.numType = type;
        [self addSubview:self.containerView];
        UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        [currentWindows addSubview:self];
        
    }
    return self;
}


- (void)collectionViewClickCancelBtnBlock:(cancelOfClick)cancelBlock sureBtnClick:(sureOfClick)sureBlock{

    self.sureOfClick = sureBlock;
    self.cancelOfClick = cancelBlock;
    
}

//点击取消按钮
- (void)remove:(UIButton *) sender {
    
    if (self.cancelOfClick) {
        
        self.cancelOfClick();
    }
    [self dissMissView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissMissView];
}

- (void)dissMissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.containerView.frame = CGRectMake(0, XSHEIGHT, XSWIDTH, 256);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//点击确定按钮
- (void)doneItemClick:(UIButton *) sender{

    if (self.sureOfClick) {
        self.sureOfClick(self.dateArray);
    }
    [self dissMissView];
    
}

#pragma mark  DELEGATE代理

//    定义展示UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

//    定义展示的section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"XSCollectionViewCell";
    
    XSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    XSCollectionViewInfo *info=self.dataList[indexPath.row];

    [cell updateCell:info];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.numType == 3) {
        for (XSCollectionViewInfo *info1 in self.dataList) {
            info1.isSelect = NO;
            [self.dateArray removeAllObjects];
        }
    }


    
    XSCollectionViewInfo *info=self.dataList[indexPath.row];

    info.isSelect = !info.isSelect;
    
    if (info.isSelect == YES) {
        [self.dateArray addObject:info.title];
    }else{
        [self.dateArray removeObject:info.title];
    }
    
//    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    [collectionView reloadData];
}


//    定义每个item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   return self.cellSize;
}

- (void)setChoose{

    switch (self.numType) {
        case AreasOfConcern:{

            self.cellSize = CGSizeMake(75, 30);
            break;
        }
        case InvestmentStage:{

            self.cellSize = CGSizeMake(105, 40);
            break;
        }
        case RegionalInvestment:{

            self.cellSize = CGSizeMake(75, 30);
            break;
        }
        case Currencies:{

            self.cellSize = CGSizeMake(105, 30);
            break;
        }
        default:
            break;
    }
    
    
}


//    margin的设置
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(15, 15, 15, 15);

}


@end
