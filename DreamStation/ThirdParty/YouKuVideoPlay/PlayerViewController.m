//
//  PlayerViewController.m
//  TestYKMediaPlayer
//
//  Created by weixinghua on 13-6-25.
//  Copyright (c) 2013年 Youku Inc. All rights reserved.
//

#import "PlayerViewController.h"
#import "YTEngineOpenViewManager.h"
#import "YYMediaPlayerEvents.h"
#import "DreamStation-swift.h"

#define MARGIN (DEVICE_TYPE_IPAD ? 15 : 10)
#define BACK_WIDTH (DEVICE_TYPE_IPAD ? 30 : 20)
#define TEXTVIEW_FONT (DEVICE_TYPE_IPAD ? 15 : 12)
#define TEXTVIEW_WIDTH (DEVICE_TYPE_IPAD ? 400 : 250)
#define TEXTVIEW_HEIGHT (DEVICE_TYPE_IPAD ? 45 : 30)
#define TOPVIEW_HEIGHT_SMALL (DEVICE_TYPE_IPAD ? 54 : 44)
#define TOPVIEW_HEIGHT_FULL (DEVICE_TYPE_IPAD ? 88 : 50)
#define STATUS_HEIGHT (DEVICE_TYPE_IPAD ? 25 : 20)

#define DEVICE_TYPE_IPAD  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

@interface PlayerViewController () <YYMediaPlayerEvents>

@property (nonatomic, strong) NSString *itemid;
@property (nonatomic, strong) NSString *itemPf;
@property (nonatomic, strong) NSString *itemQuality;
@property (nonatomic, strong) YTEngineOpenViewManager *viewManager;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) YYMediaPlayer *cloudPlayer;
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, assign) CGRect playerFrame;
@property (nonatomic, assign) CGRect cloudPlayerFrame;

@end

@implementation PlayerViewController

@synthesize player = _player;
@synthesize islocal;
@synthesize videoItem;

#pragma mark - init & dealloc

- (id)initWithVid:(NSString *)vid platform:(NSString *)platform quality:(NSString *)quality
{
    self = [super init];
    _itemid = vid;
    _itemPf = platform;
    _itemQuality = quality;
    NSLog(@"videoid:%@, platform:%@, quality:%@",vid,platform,quality);
    
    return self;
}


#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self initReturnBtn];
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
//    [self setNewOrientation:YES];//调用转屏代码
    [self interfaceOrientations:UIInterfaceOrientationLandscapeRight];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
    [_cloudPlayer stop];
   
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_cloudPlayer deinit];
}
- (BOOL)prefersStatusBarHidden{
    return false;
}

- (void)initReturnBtn{
    UIBarButtonItem *leftn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(arrowResponse)];
    self.navigationItem.leftBarButtonItem = leftn;
}
- (void)arrowResponse{
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
    [_cloudPlayer stop];
    //[self interfaceOrientations:UIInterfaceOrientationPortrait];
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)back
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    [self setNewOrientation:NO];
}
- (void)interfaceOrientations:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (void)setNewOrientations:(BOOL)fullscreen
{
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    _playerView = [[UIView alloc] init];
    _playerView.backgroundColor = [UIColor whiteColor];
    
    _cloudPlayer = [[YYMediaPlayer alloc] init];
    
    _cloudPlayer.controller = self;
    _cloudPlayer.view.clipsToBounds = YES;
    //_cloudPlayer.fullscreen = NO;
    _cloudPlayer.gravity = YYVideoGravityResizeAspect;
    _cloudPlayer.panorama = 1;
    _cloudPlayer.fullscreen = YES;
    if (_itemPf) {
        _cloudPlayer.platform = _itemPf;
    } else {
        _cloudPlayer.platform = @"youku";
    }
    
    CGSize size = self.view.bounds.size;
    CGRect frame = CGRectMake(0,0,size.width,size.height);
    self.view.frame = frame;
    
    CGFloat width = 0.f;
    if (DEVICE_TYPE_IPAD) {
        width = 681.f;
    } else {
        width = size.width;
    }
    CGFloat height = width * 9.0f / 16.0f;
    _playerView.frame = CGRectMake(0, STATUS_HEIGHT, size.width, size.height - STATUS_HEIGHT);
    _cloudPlayer.view.frame = CGRectMake(0, 0, size.height - STATUS_HEIGHT, size.width);
    
    _playerFrame = _playerView.frame;
    _cloudPlayerFrame = _cloudPlayer.view.frame;
    
    [_playerView addSubview:_cloudPlayer.view];
    [self.view addSubview:_playerView];
    
    [self initViews];
    
    [_cloudPlayer addEventsObserver:self];
    
    _cloudPlayer.clientId = @"ec5237d524fb5d81";
    _cloudPlayer.clientSecret = @"413f60d980e258353311a167317dd1de";
    
    // 初始化播放器界面管理器
    _viewManager = [[YTEngineOpenViewManager alloc] initWithPlayer:_cloudPlayer];
    [_cloudPlayer addEventsObserver:_viewManager];
    
    // youku
    // mv: XMzU0OTQ2MDUy 爱情公寓: XNDMzNDAzNjQw 老友记: XNTg5NTkxMzAw
    // 龙门镖局: XNTg5OTE4MDEy 琅琊榜第10集: XMTM0MzE3NTAyNA== 大好时光01: XMTM2MTIwODM4MA==
    
    // tudou
    // 学校2015第一集:TfNdUm9wxIE 异镇01:LavAOw4K2KA running man:3ATirEqDEh0 原创:caCSxH7sM7c
    
    // cloud
    // CNDEyMzI= CNjY2NTg0 CNDA= CMzAzMzI4MA== CMzY3MjczNg==
    // 32分11秒 15分 28秒 3分48秒 2小时03分19秒
    
    // 播放视频
    if (!_itemid) {
        _itemid = @"XNTg5OTE4MDEy";
    }
    
    if (!_itemQuality) {
        _itemQuality = kYYVideoQualityFLV;
    }
    
    if (!islocal) {
        [_cloudPlayer playVid:_itemid quality:_itemQuality password:nil from:0];
    } else {
        if (self.videoItem) {
            [_cloudPlayer playVideo:(id<YYMediaPlayerItem>)self.videoItem quality:_itemQuality from:0 oldEncrypt:NO];
        }
    }
    
}

- (void)layout:(BOOL)fullscreen
{
    CGFloat backHeight = _backButton.bounds.size.height;
    CGFloat y = 0;
    
    if (!fullscreen) {
        _playerView.frame = _playerFrame;
        _cloudPlayer.view.frame = _cloudPlayerFrame;
        y = (TOPVIEW_HEIGHT_SMALL - backHeight) / 2;
        _backButton.frame = CGRectMake(MARGIN, y , BACK_WIDTH, backHeight);
    } else {
        _playerView.frame = self.view.frame;
        _cloudPlayer.view.frame = self.view.frame;
        y = (TOPVIEW_HEIGHT_FULL - STATUS_HEIGHT - backHeight) / 2 + STATUS_HEIGHT;
        _backButton.frame = CGRectMake(MARGIN, y, BACK_WIDTH, _backButton.bounds.size.height);
    }
    _textView.frame = CGRectMake(_cloudPlayer.view.center.x - TEXTVIEW_WIDTH/2, _cloudPlayer.view.center.y - TEXTVIEW_HEIGHT/2, TEXTVIEW_WIDTH, TEXTVIEW_HEIGHT);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orien
{
    if (DEVICE_TYPE_IPAD) {
        if (orien == UIInterfaceOrientationPortrait || orien == UIInterfaceOrientationPortraitUpsideDown) {
            return NO;
        } else {
            return [self rotatePlayer:orien];
        }
    } else {
        if (orien == UIInterfaceOrientationPortraitUpsideDown) {
            return NO;
        } else {
            return [self rotatePlayer:orien];
        }
    }
}

- (BOOL)shouldAutorotate
{
    UIInterfaceOrientation orien = [self interfaceOrientation:[UIDevice currentDevice].orientation];
    return [self rotatePlayer:orien];
}

- (BOOL)rotatePlayer:(UIInterfaceOrientation)orien
{
    if (!DEVICE_TYPE_IPAD) {
        if (orien == UIInterfaceOrientationPortrait &&
            self.interfaceOrientation != orien) {
            [_cloudPlayer setFullscreen:NO];
        } else if (UIInterfaceOrientationIsLandscape(orien)) {
            UIInterfaceOrientation corien = self.interfaceOrientation;
            if (!UIInterfaceOrientationIsLandscape(corien)) {
                [_cloudPlayer setFullscreen:YES];
            }
        }
    }
    return YES;
}

- (NSInteger)interfaceOrientation:(UIDeviceOrientation)orien
{
    if (DEVICE_TYPE_IPAD) {
        switch (orien) {
            case UIDeviceOrientationLandscapeLeft:
                return UIInterfaceOrientationLandscapeRight;
            case UIDeviceOrientationLandscapeRight:
                return UIInterfaceOrientationLandscapeLeft;
            default:
                return -1;
        }
    } else {
        switch (orien) {
            case UIDeviceOrientationPortrait:
                return UIInterfaceOrientationPortrait;
            case UIDeviceOrientationLandscapeLeft:
                return UIInterfaceOrientationLandscapeRight;
            case UIDeviceOrientationLandscapeRight:
                return UIInterfaceOrientationLandscapeLeft;
            default:
                return -1;
        }
    }
}

- (void)initViews
{
    _backButton = [[UIButton alloc] init];
    UIImage *backImg = [UIImage imageNamed:@"back"];
    [_backButton setImage:backImg
                 forState:UIControlStateNormal];
    _backButton.adjustsImageWhenHighlighted = NO;
    [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    _backButton.bounds = CGRectMake(0, 0, BACK_WIDTH, backImg.size.height);
    [_playerView addSubview:_backButton];
    
    // 返回错误码
    _textView = [[UITextView alloc] init];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:TEXTVIEW_FONT];
    _textView.editable = NO;
    _textView.userInteractionEnabled = NO;
    [_textView setTextAlignment:NSTextAlignmentCenter];
    [_cloudPlayer.view addSubview:_textView];
}

- (void)backAction:(UIButton *)sender {
    if (_cloudPlayer.fullscreen) {
        if (DEVICE_TYPE_IPAD) {
            [_cloudPlayer setFullscreen:!_cloudPlayer.fullscreen];
        } else {
            [self setNewOrientation:!_cloudPlayer.fullscreen];
        }
    } else {
        [_cloudPlayer removeEventsObserver:_viewManager];
        [_cloudPlayer.controller.navigationController popViewControllerAnimated:YES];
        [_cloudPlayer stop];
        [_cloudPlayer deinit];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    }
}

- (void)setNewOrientation:(BOOL)fullscreen
{
    
    UIDeviceOrientation lastDeviceOrien = [UIDevice currentDevice].orientation;
    UIDeviceOrientation deviceOiren = fullscreen ?
    UIDeviceOrientationLandscapeLeft : UIDeviceOrientationPortrait;
    
    if([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        NSNumber *oiren = [NSNumber numberWithInt:deviceOiren];
        [[UIDevice currentDevice] setValue:oiren forKey:@"orientation"];
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:oiren];
    }
    if (lastDeviceOrien == deviceOiren) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0) {
            [UIViewController attemptRotationToDeviceOrientation];
        }
    }
}

- (void)endPlayCode:(YYErrorCode)err
{
    NSString *tip;
    switch (err) {
        case YYPlayCompleted:
            tip = @"该视频已播放完成，点击重新播放";
            _textView.text = tip;
            break;
        case YYPlayCanceled:
            break;
        case YYErrorClientFormat:
            tip = [NSString stringWithFormat:@"client参数格式错误，错误码：%ld", (long)err];
            _textView.text = tip;
            break;
        case YYErrorInvalidClient:
            tip = [NSString stringWithFormat:@"client无效或sdk版本过低，错误码：%ld", (long)err];
            _textView.text = tip;
            break;
        case YYErrorPermissionDeny:
            tip = [NSString stringWithFormat:@"视频无权限播放，错误码：%ld", (long)err];
            _textView.text = tip;
            break;
        case YYErrorInitOpenView:
            tip = [NSString stringWithFormat:@"初始化界面无效，错误码：%ld", (long)err];
            _textView.text = tip;
            break;
        case YYDataSourceError:
            tip = [NSString stringWithFormat:@"媒体文件错误,错误码：%ld", (long)err];
            _textView.text = tip;
            break;
        case YYNetworkError:
            tip = [NSString stringWithFormat:@"网络连接超时，错误码：%ld, 点击重试", (long)err];
            _textView.text = tip;
            break;
        case YYErrorBundleTempered:
            tip = [NSString stringWithFormat:@"资源加载无效，错误码：%ld", (long)err];
            _textView.text = tip;
            break;
            
        default:
            tip = [NSString stringWithFormat:@"播放发生错误，错误码：%ld, 点击重试", (long)err];
            _textView.text = tip;
            break;
    }
}

- (void)startPlay
{
    if (_viewManager) {
        _textView.hidden = YES;
    }
}

- (void)screenWillChange:(BOOL)fullscreen
{
    if (fullscreen) {
        UIImage *backImg = [UIImage imageNamed:@"back_full"];
        [_backButton setImage:backImg
                     forState:UIControlStateNormal];
    } else {
        UIImage *backImg = [UIImage imageNamed:@"back"];
        [_backButton setImage:backImg
                     forState:UIControlStateNormal];
    }
}

@end
