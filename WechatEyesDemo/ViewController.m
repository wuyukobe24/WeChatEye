//
//  ViewController.m
//  WechatEyesDemo
//
//  Created by WangXueqi on 17/7/31.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "ViewController.h"

#define K_ScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])// 当前屏幕宽
#define K_ScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds])// 当前屏幕高
#define k_baseViewFrame _upView.frame
static NSString * cellId = @"cellId";
@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * baseTableView;
@property(nonatomic,strong)UIView * upView;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)CAShapeLayer * eyeFirstLightLayer;
@property(nonatomic,strong)CAShapeLayer * eyeSecondLightLayer;
@property(nonatomic,strong)CAShapeLayer * eyeballLayer;
@property(nonatomic,strong)CAShapeLayer * topEyesocketLayer;
@property(nonatomic,strong)CAShapeLayer * bottomEyesocketLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"微信眼睛";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.baseTableView];
    [self.upView.layer addSublayer:self.eyeFirstLightLayer];
    [self.upView.layer addSublayer:self.eyeSecondLightLayer];
    [self.upView.layer addSublayer:self.eyeballLayer];
    [self.upView.layer addSublayer:self.topEyesocketLayer];
    [self.upView.layer addSublayer:self.bottomEyesocketLayer];
    [self setupAnimation];
}

- (UIView *)upView {
    
    if (!_upView) {
        _upView = [[UIView alloc]initWithFrame:CGRectMake(K_ScreenWidth*3/7, 70, K_ScreenWidth/7, K_ScreenWidth/7*2/3)];
    }
    return _upView;
}

- (UIView *)backView {
    
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, K_ScreenWidth, K_ScreenHeight)];
        _backView.backgroundColor = [UIColor blackColor];
    }
    return _backView;
}

- (UITableView *)baseTableView {
    
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_ScreenWidth, K_ScreenHeight)];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.rowHeight = 50;
        _baseTableView.backgroundView = self.backView;
        _baseTableView.tableFooterView = [[UIView alloc]init];
        [self.backView addSubview:self.upView];
    }
    return _baseTableView;
}

- (CAShapeLayer *)eyeFirstLightLayer {
    
    if (!_eyeFirstLightLayer) {
        _eyeFirstLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, CGRectGetHeight(k_baseViewFrame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(k_baseViewFrame) * 0.15
                                                        startAngle:(230.f / 180.f) * M_PI
                                                          endAngle:(265.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeFirstLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 5.f;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeFirstLightLayer;
}

- (CAShapeLayer *)eyeSecondLightLayer {
    
    if (!_eyeSecondLightLayer) {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, CGRectGetHeight(k_baseViewFrame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(k_baseViewFrame) * 0.15
                                                        startAngle:(211.f / 180.f) * M_PI
                                                          endAngle:(220.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeSecondLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeSecondLightLayer.lineWidth = 5.f;
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeSecondLightLayer;
}

- (CAShapeLayer *)eyeballLayer {
    
    if (!_eyeballLayer) {
        _eyeballLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, CGRectGetHeight(k_baseViewFrame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(k_baseViewFrame) * 0.25
                                                        startAngle:(0.f / 180.f) * M_PI
                                                          endAngle:(360.f / 180.f) * M_PI
                                                         clockwise:YES];//radius控制大小
        _eyeballLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeballLayer.lineWidth = 1.f;
        _eyeballLayer.path = path.CGPath;
        _eyeballLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeballLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return _eyeballLayer;
}

- (CAShapeLayer *)topEyesocketLayer {
    
    if (!_topEyesocketLayer) {
        _topEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, CGRectGetHeight(k_baseViewFrame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(k_baseViewFrame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(k_baseViewFrame), CGRectGetHeight(k_baseViewFrame) / 2)
                     controlPoint:CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, center.y - center.y - 20)];
        _topEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.lineWidth = 1.f;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _topEyesocketLayer;
}

- (CAShapeLayer *)bottomEyesocketLayer {
    
    if (!_bottomEyesocketLayer) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, CGRectGetHeight(k_baseViewFrame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(k_baseViewFrame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(k_baseViewFrame), CGRectGetHeight(k_baseViewFrame) / 2)
                     controlPoint:CGPointMake(CGRectGetWidth(k_baseViewFrame) / 2, center.y + center.y + 20)];
        _bottomEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.lineWidth = 1.f;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _bottomEyesocketLayer;
}

- (void)setupAnimation {
    
    self.eyeFirstLightLayer.lineWidth = 0.f;
    self.eyeSecondLightLayer.lineWidth = 0.f;
    self.eyeballLayer.opacity = 0.f;//透明度
    _bottomEyesocketLayer.strokeStart = 0.5f;
    _bottomEyesocketLayer.strokeEnd = 0.5f;
    _topEyesocketLayer.strokeStart = 0.5f;
    _topEyesocketLayer.strokeEnd = 0.5f;
}

- (void)animationWith:(CGFloat)y {
    
    CGFloat flag = self.view.frame.origin.y*2-20;
    NSLog(@"flag == %f",flag);
    
    if (y<flag) {
        if (self.eyeFirstLightLayer.lineWidth < 5) {
            self.eyeFirstLightLayer.lineWidth += 1;
            self.eyeSecondLightLayer.lineWidth += 1;
        }
    }
    
    if (y<flag-10) {
        if (self.eyeballLayer.opacity <= 1) {
            self.eyeballLayer.opacity += 0.1;
        }
    }
    
    if (y<flag-20) {
        if (self.topEyesocketLayer.strokeEnd < 1 && self.topEyesocketLayer.strokeStart > 0) {
            
            self.topEyesocketLayer.strokeEnd += 0.1;
            self.topEyesocketLayer.strokeStart -= 0.1;
            self.bottomEyesocketLayer.strokeEnd += 0.1;
            self.bottomEyesocketLayer.strokeStart -= 0.1;
        }
    }
    
    if (y>flag-20) {
        if (self.topEyesocketLayer.strokeEnd > 0.5 && self.topEyesocketLayer.strokeStart < 0.5) {
            
            self.topEyesocketLayer.strokeEnd -= 0.1;
            self.topEyesocketLayer.strokeStart += 0.1;
            self.bottomEyesocketLayer.strokeEnd -= 0.1;
            self.bottomEyesocketLayer.strokeStart += 0.1;
        }
    }
    
    if (y>flag-10) {
        if (self.eyeballLayer.opacity >= 0) {
            self.eyeballLayer.opacity -= 0.1;
        }
    }
    
    if (y>flag) {
        if (self.eyeFirstLightLayer.lineWidth > 0) {
            self.eyeFirstLightLayer.lineWidth -= 1;
            self.eyeSecondLightLayer.lineWidth -= 1;
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentY = scrollView.contentOffset.y+74;
    [self animationWith:contentY];
    NSLog(@"contentY === %f",contentY);
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.text = @"下拉";
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
