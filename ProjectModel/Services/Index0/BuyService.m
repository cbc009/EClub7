//
//  BuyService.m
//  Club
//
//  Created by MartinLi on 14-8-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BuyService.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "MenuListViewController.h"
#import "MenuCollectionCell.h"
#import "Goods_type.h"
#import "JSONModelLib.h"
#import "Type_goods.h"
#import "MJRefresh.h"
#import "AdvertPic.h"
#import "MartinLiPageScrollView.h"
#import "SharedAction.h"
#import "Index0Service.h"
#define MainGrayColor [UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1]
@implementation BuyService

-(void)setSelectedColorInCollectionView:(UICollectionView *)collectionView withSelectedRow:(NSInteger)row withDatas:(NSArray *)datas{
    NSInteger count = datas.count;
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indpath = [NSIndexPath indexPathForRow:i inSection:0];
        MenuCollectionCell *cell = (MenuCollectionCell *)[collectionView cellForItemAtIndexPath:indpath];
        if (i==row) {
            cell.titleLabel.textColor = MainGreenColor;
        }else{
            cell.titleLabel.textColor = [UIColor blackColor];
        }
    }
}

/*
    加载商品类别
 */
-(void)loadGoodTypesWithToken:(NSString *)token andUser_type:(NSInteger )user_type InViewController:(Index0_3ViewController *)viewController{
    [SVProgressHUD show];
    NSString *urlString = [NSString stringWithFormat:GoodsTypeURL,token,user_type];
    [Goods_type getModelFromURLWithString:urlString completion:^(Goods_type *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        if (model.status==2) {
            viewController.goodTypes = model.info.goods_type;
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SharedAction  showErrorWithStatus:model.status andError:model.error witViewController:viewController];
        }
    }];
}

/*
    刷新商品
 */

-(void)type_goodsWithToken:(NSString *)token andUser_type:(NSInteger )user_type andSubtypeId:(NSString *)subtypeId andPageString:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Type_goodsURL,token,user_type,subtypeId,pageString];
    [Type_goods getModelFromURLWithString:urlString completion:^(Type_goods *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
@end
