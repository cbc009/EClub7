//
//  SellerService.m
//  Club
//
//  Created by MartinLi on 15-3-28.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SellerService.h"
#import "Seller_Seller_Goods.h"
#import "Seller_Info.h"
#import "GoodsCountDownModel.h"
#import "Public_Seller.h"
 #import "Public_Seller_info_model.h"
#import <JSONModelLib.h>
#import "Status.h"
#import "SVProgressHUD.h"
#import "Seller_Seller_Comment.h"
#import "ChangeBaiduApi.h"
@implementation SellerService
-(void)sellerSellerGood_typesWith:(NSString *)good_type andAgentId:(NSString *)agent_id andSeller_id:(NSString *)seller_id andLifehall_id:(NSString *)lifehall_id andPage:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString=[NSString stringWithFormat:Seller_Seller_Goods_URL,good_type,agent_id,seller_id,lifehall_id,pageString];
    [Seller_Seller_Goods getModelFromURLWithString:urlString completion:^( Seller_Seller_Goods *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)publickSellerListWithTypeString:(NSString *)typeString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Public_Seller_Type_URL,typeString];
    [Public_Seller getModelFromURLWithString:urlString completion:^(Public_Seller *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)publicSellerInfoWithAgent_id:(NSString *)agent_id anrTypeString:(NSString *)typeSting inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Public_Seller_Info_URL,agent_id,typeSting];
    [Public_Seller_info_model getModelFromURLWithString:urlString completion:^(Public_Seller_info_model *model,JSONModelError *error){
         [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];

}
-(void)sellerSellerCommentInfoWithSeller_id:(NSString *)seller_id andPageString:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString=[NSString stringWithFormat:Seller_Seller_Comment_Info_URL,seller_id,pageString];
    [Seller_Seller_Comment getModelFromURLWithString:urlString completion:^(Seller_Seller_Comment *model,JSONModelError*eroor){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:eroor andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)changeBaiduApiWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:BaiDuApi,longitude,latitude];
    NSLog(@"%@",urlString);
    [ChangeBaiduApi getModelFromURLWithString:urlString completion:^(ChangeBaiduApi *model,JSONModelError *error){
        if (model.status==0) {
           
            done(model);
        }
    }];
}
-(void)sellerOrderReturnwithToken:(NSString *)token andUser_type:(NSInteger)user_type andOrder_id:(NSString *)order_id inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Seller_Order_Return_URL,token,user_type,order_id];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
    }];
}
-(void)sellerCountDownWithGoodsType:(NSString *)goode_type andGoodId:(NSString *)good_id inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Seller_Countdown_URL,goode_type,good_id];
    [GoodsCountDownModel getModelFromURLWithString:urlString completion:^(GoodsCountDownModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)sellerInfoWithAgentid:(NSString*)agent_id andSeller_type:(NSString *)seller_type andSellerid:(NSString *)seller_id inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString = [NSString stringWithFormat:Public_Info_URL,agent_id,seller_id];
    [Public_Seller_info_model getModelFromURLWithString:urlString completion:^(Public_Seller_info_model *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
    
}

@end
