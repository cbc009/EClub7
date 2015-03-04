//
//  SharedUser.m
//  DaXiaProject
//
//  Created by Gao Huang on 14-10-30.
//  Copyright (c) 2014年 None. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData

+(SharedData *)sharedInstance{
    static SharedData *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[SharedData alloc] init];
    });
    return sharedUser;
}

-(void)setLoginStatus:(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginStatus forKey:@"loginStatus"];
    [userDefaults synchronize];
}

-(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginStatus"];
}

-(void)setLoginname:(NSString *)loginname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginname forKey:@"loginname"];
    [userDefaults synchronize];
}

-(NSString *)loginname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginname"];
}

-(void)setPassword:(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
}

-(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"password"];
}

-(void)setIccard:(NSString *)iccard{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:iccard forKey:@"iccard"];
    [userDefaults synchronize];
}
-(NSString *)iccard{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"iccard"];
}

-(void)setRedbag:(CGFloat )redbag{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:redbag forKey:@"redbag"];
    [userDefaults synchronize];
}
-(CGFloat )redbag{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults floatForKey:@"redbag"];
}

-(void)setAmount:(NSString *)amount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:amount forKey:@"amount"];
    [userDefaults synchronize];
}

-(void)setCreatePayPrice:(float)createPayPrice{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:createPayPrice forKey:@"createPayPrice"];
    [userDefaults synchronize];
}
-(float)createPayPrice{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults floatForKey:@"createPayPrice"];
}

-(void)setFingerIsOpened:(NSString *)fingerIsOpened{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:fingerIsOpened forKey:@"fingerIsOpened"];
    [userDefaults synchronize];
}
-(NSString *)fingerIsOpened{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"fingerIsOpened"];
}

-(void)setPayPassword:(NSString *)payPassword{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:payPassword forKey:@"payPassword"];
    [userDefaults synchronize];
}
-(NSString *)payPassword{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"payPassword"];
}
@end
