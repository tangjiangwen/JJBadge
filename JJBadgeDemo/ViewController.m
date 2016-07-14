//
//  ViewController.m
//  JJBadgeDemo
//
//  Created by Jiangwen Tang on 16/7/11.
//  Copyright © 2016年 Jiangwen Tang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JJBadge.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat h = 50;
    CGFloat w = 50;
    CGFloat space = 40;
    NSUInteger count = 6;
    for (NSInteger i = 0; i < count; i++) {
        UIView *v = [UIView new];
        NSInteger col = 2;
        v.frame = (CGRect){space + (w + space) * (i / col), space + (h + space) * (i % col), w, h};
        v.backgroundColor = [UIColor colorWithRed:(240 / 255.f)
                                            green:(240 / 255.f)
                                             blue:(240 / 255.f)
                                            alpha:1];
        [self.view addSubview:v];
        switch (i) {
            case 0:
                [v showNewBadgeByStyle:JJBadgeStyleNormal];
                break;
            case 1:
                [v showNewBadgeByStyle:JJBadgeStyleCircle];
                break;
            case 2:
                [v showRedDotBadgeByStyle:JJBadgeStyleNormal];
                break;
            case 3:
                [v showRedDotBadgeByStyle:JJBadgeStyleCircle];
                break;
            case 4:
                [v showNumberBadge:i style:JJBadgeStyleNormal];
                break;
            case 5:
                [v showNumberBadge:i style:JJBadgeStyleCircle];
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
