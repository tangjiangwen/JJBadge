//
//  UIView+Badge.h
//  JJBadgeDemo
//
//  Created by Jiangwen Tang on 16/7/11.
//  Copyright © 2016年 Jiangwen Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -- types definition
typedef NS_ENUM(NSUInteger, JJBadgeType)
{
    JJBadgeTypeRedDot = 0,          /* red dot type */
    JJBadgeTypeNumber,              /* badge with number */
    JJBadgeTypeNew                  /* badge with a fixed text "new" */
};

typedef NS_ENUM(NSUInteger, JJBadgeStyle)
{
    JJBadgeStyleNormal = 0,          /* badge style rectangle  */
    JJBadgeStyleCircle,              /* badge style circle */
};

typedef NS_ENUM(NSUInteger, JJBadgeSizeType) {
    JJBadgeSizeTypeNormal = 0,      /* badge size systom */
    JJBadgeSizeTypeCustom = 1       /* badge size custom */
};

@interface UIView (JJBadge)

#pragma mark -- badge apis
@property (nonatomic, strong, setter=setbadge:, getter=badge) UILabel *badge;
@property (nonatomic, setter=setbadgeOriginX:, getter=badgeOriginX) CGFloat badgeOriginX;
@property (nonatomic, getter=badgeOriginY, setter=setbadgeOriginY:) CGFloat badgeOriginY;
@property (nonatomic, getter=showAllNumbers, setter=setshowAllNumbers:) BOOL showAllNumbers;//<展示完整的数字 (默认超过100展示99+)  等于0也展示


/**
 *  show badge with red dot style and WBadgeAnimTypeNone by default.
 */
- (void)showRedDotBadge;
- (void)showRedDotBadgeBySizeType:(JJBadgeSizeType)sizeType;
- (void)showRedDotBadgeByStyle:(JJBadgeStyle)style;
- (void)showRedDotBadgeByStyle:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType;

/**
 * show badge with WBadgeStyleNumber style
 */
- (void)showNewBadge;
- (void)showNewBadgeBySizeType:(JJBadgeSizeType)sizeType;
- (void)showNewBadgeByStyle:(JJBadgeStyle)style;
- (void)showNewBadgeByStyle:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType;

/**
 * show badge with showNumberBadgeWithValue style
 */
- (void)showNumberBadge:(NSInteger)value;
- (void)showNumberBadge:(NSInteger)value sizeType:(JJBadgeSizeType)sizeType;
- (void)showNumberBadge:(NSInteger)value style:(JJBadgeStyle)style;
- (void)showNumberBadge:(NSInteger)value style:(JJBadgeStyle)style sizeType:(JJBadgeSizeType)sizeType;

/**
 *  clear badge
 */
- (void)clearBadge;

/**
 *  get current badgeType
 */
- (JJBadgeType)getBadgeType;

/**
 *  get bage show
 *
 */

- (BOOL)isShowBage;

@end
