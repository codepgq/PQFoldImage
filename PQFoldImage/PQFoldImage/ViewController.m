//
//  ViewController.m
//  PQFoldImage
//
//  Created by ios on 16/8/26.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;

@property (nonatomic,weak) CAGradientLayer * gradientL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 0);
    
    CAGradientLayer * gradientL = [CAGradientLayer layer];
    gradientL.frame = self.bottomImageV.bounds;
    gradientL.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    self.gradientL = gradientL;
    self.gradientL.opacity = 0;
    [self.bottomImageV.layer addSublayer:gradientL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)foldImage:(UIPanGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.gradientL.opacity = 0;
                self.topImageV.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint curP = [sender locationInView:sender.view];
            
            //angle
            CGFloat angle = curP.y * M_PI / 180.0;
            
            //创建阴影效果
            self.gradientL.opacity = curP.y * 1 / 256.0;
            self.topImageV.layer.transform = CATransform3DMakeRotation(-angle, 1, 0, 0);
        }
            break;
            
        default:
            break;
    }
}

@end
