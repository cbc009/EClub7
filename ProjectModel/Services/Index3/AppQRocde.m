//
//  AppQRocde.m
//  Club
//
//  Created by MartinLi on 15-1-5.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "AppQRocde.h"
#import "Guide_code.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"

@implementation AppQRocde
-(void)loadDataWithToken:(NSString *)token AndUser_type:(NSInteger )user_type withDone:(doneWithObject)done
{
    NSString *urlString= [NSString stringWithFormat:QRCode_Guide_code,token,user_type];
    [Guide_code getModelFromURLWithString:urlString completion:^(Guide_code *object,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info withDone:done];
    }];

}
@end
