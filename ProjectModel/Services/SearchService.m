//
//  SearchService.m
//  Club
//
//  Created by MartinLi on 14-12-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "SearchService.h"
#import "Goods_type.h"
#import "Type_goods.h"
#import "SVProgressHUD.h"

#import "JSONModelLib.h"
#import "SharedAction.h"
#import "Search_label.h"
@implementation SearchService

-(void)goodsSearchWithToken:(NSString *)token andUser_type:(NSInteger )user_type anName:(NSString *)name inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done
{
    NSString *user_type1 =  [NSString stringWithFormat: @"%ld",(long)user_type];;
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:user_type1,token,name,nil] forKeys:[NSArray arrayWithObjects:@"user_type",@"token",@"name", nil]];
    [JSONHTTPClient postJSONFromURLWithString:Goods_search_URL params:dict completion:^(id object ,JSONModelError *error){
        NSInteger status1 =[ (NSNumber *)[object objectForKey:@"status"] integerValue];
        NSString *error1 = (NSString *)[object objectForKey:@"error"];
        NSDictionary *modelInfo = (NSDictionary *)[object objectForKey:@"info"];
          NSArray *array = (NSArray *)[modelInfo objectForKey:@"goods"];
        [SharedAction commonActionWithUrl:Goods_search_URL andStatus:status1 andError:error1 andJSONModelError:error andObject:array inTabBarController:tabBarController withDone:done];
    }];
}

-(void)searchLabelwithToken:(NSString *)token andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done{
//    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Goods_search_Label_URL,token,user_type];
    [Search_label getModelFromURLWithString:urlString completion:^(Search_label *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}

@end
