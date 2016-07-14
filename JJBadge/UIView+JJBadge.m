//
//  UIView+Badge.m
//  JJBadgeDemo
//
//  Created by Jiangwen Tang on 16/7/11.
//  Copyright © 2016年 Jiangwen Tang. All rights reserved.
//

#import "UIView+JJBadge.h"
#import <objc/runtime.h>

//< 亲自测量 default   width = {20 27 35 } height = {20}  system
#define BADGE_VIEW_REDDOT_WIDTH          ((sizeType == JJBadgeSizeTypeNormal) ? 8.0 : 8.0)
#define BADGE_VIEW_HEIGHT                ((sizeType == JJBadgeSizeTypeNormal) ? 15.0 : 15.0)
#define BADGE_VIEW_SAMLL_WIDTH           ((sizeType == JJBadgeSizeTypeNormal) ? 15.0 : 15.0)
#define BADGE_VIEW_STANDARD_WIDTH        ((sizeType == JJBadgeSizeTypeNormal) ? 22.0 : 22.0)
#define BADGE_VIEW_BIG_WIDTH             ((sizeType == JJBadgeSizeTypeNormal) ? 27.0 : 27.0)

#define BADGE_VIEW_NEW_FONT              ((sizeType == JJBadgeSizeTypeNormal) ? 10.0 : 10.0)
#define BADGE_VIEW_NUMBER_FONT           ((sizeType == JJBadgeSizeTypeNormal) ? 12.0 : 12.0)

//key for associative methods during runtime
static char badgeLabelKey;
static char badgeOriginXKey;
static char badgeOriginYKey;
static char badgeShowallNumbersKey;

@implementation UIView (JJBadge)

#pragma mark -- public methods

/**
 *  clear badge
 */
- (void)clearBadge
{
    if(self.badge)  self.badge.hidden = YES;
}


#pragma mark -- private methods

- (void)showRedDotBadge{
    [self showRedDotBadgeByStyle:JJBadgeStyleNormal sizeType:JJBadgeSizeTypeNormal];
}

- (void)showRedDotBadgeBySizeType:(JJBadgeSizeType)sizeType{
    [self showRedDotBadgeByStyle:JJBadgeStyleNormal sizeType:sizeType];
}

- (void)showRedDotBadgeByStyle:(JJBadgeStyle)style{
    [self showRedDotBadgeByStyle:style sizeType:JJBadgeSizeTypeNormal];
}

- (void)showRedDotBadgeByStyle:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType{
    [self configBadge:JJBadgeTypeRedDot style:style sizeType:sizeType value:0];
}

/* --showNewBadge -- */
- (void)showNewBadge{
    [self showNewBadgeByStyle:JJBadgeStyleNormal sizeType:JJBadgeSizeTypeNormal];
}

- (void)showNewBadgeBySizeType:(JJBadgeSizeType)sizeType{
    [self showNewBadgeByStyle:JJBadgeStyleNormal sizeType:sizeType];
}

- (void)showNewBadgeByStyle:(JJBadgeStyle)style{
    [self showNewBadgeByStyle:style sizeType:JJBadgeSizeTypeNormal];
}

- (void)showNewBadgeByStyle:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType{
    [self configBadge:JJBadgeTypeNew style:style sizeType:sizeType value:0];
}

/* --showNumberBadge -- */
- (void)showNumberBadge:(NSInteger)value{
    [self showNumberBadge:value style:JJBadgeStyleNormal sizeType:JJBadgeSizeTypeNormal];
}

- (void)showNumberBadge:(NSInteger)value sizeType:(JJBadgeSizeType)sizeType{
    [self showNumberBadge:value style:JJBadgeStyleNormal sizeType:sizeType];
}

- (void)showNumberBadge:(NSInteger)value style:(JJBadgeStyle)style{
    [self showNumberBadge:value style:style sizeType:JJBadgeSizeTypeNormal];
}

- (void)showNumberBadge:(NSInteger)value style:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType{
    if (!self.showAllNumbers && value <= 0) {
        [self clearBadge];
        return;
    }
    [self configBadge:JJBadgeTypeNumber style:style sizeType:sizeType value:value];
}


//lazy loading
- (void)badgeInit
{
    if (nil == self.badge) {
        self.badge = [[UILabel alloc] initWithFrame:CGRectZero];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.backgroundColor = [UIColor colorWithRed:(228 / 255.f)
                                                     green:(32 / 255.f)
                                                      blue:(38 / 255.f)
                                                     alpha:1];
        self.badge.textColor = [UIColor whiteColor];
        self.badge.text = @"";
        self.badge.layer.cornerRadius = self.badge.width / 2;
        self.badge.layer.masksToBounds = YES;//very important
        [self addSubview:self.badge];
    }
}

- (void)configBadge:(JJBadgeType)type style:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType value:(NSInteger)value{
    [self badgeInit];
    
    self.badge.tag = type;
    
    switch (type) {
        case JJBadgeTypeRedDot:
        {
            self.badge.text = @"";
            self.badge.width = BADGE_VIEW_REDDOT_WIDTH;
            self.badge.height = BADGE_VIEW_REDDOT_WIDTH;
        }
            break;
        case JJBadgeTypeNumber:
        {
            if (value >=100) {
                self.badge.text = self.showAllNumbers ? @(value).description : @"99+";
            } else {
                self.badge.text = [NSString stringWithFormat:@"%@", @(value)];
            }
            
            if(value >= 100){
                self.badge.width = BADGE_VIEW_BIG_WIDTH;
            }
            else if(value >= 10){
                self.badge.width = BADGE_VIEW_STANDARD_WIDTH;
            }
            else{
                self.badge.width = BADGE_VIEW_SAMLL_WIDTH;
            }
            self.badge.height = BADGE_VIEW_HEIGHT;
            self.badge.font = [UIFont systemFontOfSize:BADGE_VIEW_NUMBER_FONT];
        }
            break;
        case JJBadgeTypeNew:
        {
            self.badge.text = @"new";
            self.badge.width = BADGE_VIEW_BIG_WIDTH;
            self.badge.height = BADGE_VIEW_HEIGHT;
            self.badge.font = [UIFont systemFontOfSize:BADGE_VIEW_NEW_FONT];
        }
            break;
        default:
            break;
    }
    if(style == JJBadgeStyleNormal){
        self.badge.center = CGPointMake(self.width, 0);
    }
    else if(style == JJBadgeStyleCircle){
        CGFloat radius = self.width/2;
        self.badge.center = CGPointMake(ceil(radius + sqrt(2)/2*radius), ceil(radius - sqrt(2)/2*radius));
    }
    
    //*********自己定义的X Y*************//
    if([self hasBadgeOriginX]){
        self.badge.left = self.badgeOriginX;
    }
    
    if([self hasBadgeOriginY]){
        self.badge.top = self.badgeOriginY;
    }
    //********************************//
    
    self.badge.layer.cornerRadius = self.badge.height / 2;
    self.badge.hidden = NO;
}

#pragma mark -- setter/getter
- (UILabel *)badge
{
    UILabel* lbl = objc_getAssociatedObject(self, &badgeLabelKey);
    if(lbl == nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [self setbadge:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.backgroundColor = [UIColor colorWithRed:(228 / 255.f)
                                              green:(32 / 255.f)
                                               blue:(38 / 255.f)
                                              alpha:1];
        lbl.textColor = [UIColor whiteColor];
        lbl.text = @"";
        lbl.layer.masksToBounds = YES;//very important
        lbl.hidden = YES;
        [self addSubview:lbl];
    }
    return lbl;
}

- (void)setbadge:(UILabel *)label
{
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hasBadgeOriginX{
    return objc_getAssociatedObject(self, &badgeOriginXKey) ? YES : NO;
}

-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginXKey);
    return number.floatValue;
}

-(void) setbadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badge.left = badgeOriginX;
}

- (BOOL)hasBadgeOriginY{
    return objc_getAssociatedObject(self, &badgeOriginYKey) ? YES : NO;
}

-(CGFloat) badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginYKey);
    return number.floatValue;
}

- (BOOL) showAllNumbers{
    return objc_getAssociatedObject(self, &badgeShowallNumbersKey) ? YES : NO;
}

- (void) setshowAllNumbers:(BOOL)showAllNumbers{
    NSNumber *number = [NSNumber numberWithBool:showAllNumbers];
    objc_setAssociatedObject(self, &badgeShowallNumbersKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) setbadgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badge.top = badgeOriginY;
}

- (JJBadgeType)getBadgeType{
    if(self.badge){
        return [self.badge tag];
    }
    return JJBadgeTypeRedDot;
}

- (BOOL)isShowBage {
    
    return self.badge.hidden;
}

@end
