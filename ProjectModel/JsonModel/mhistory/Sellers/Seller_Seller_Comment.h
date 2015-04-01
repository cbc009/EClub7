 //
 //  Seller_Seller_Comment.h 
 //  auton //
 //  Created by MartinLi on 15-3-5. 
 //  Copyright (c) 2015年 Club. All rights reserved.
 //
 #import "JSONModel.h"

@protocol Seller_Seller_Comment_arr_comment_info <NSObject>
@end
@protocol Seller_Seller_Comment_sub_comment_info <NSObject>
@end
@protocol Sub_Comment_Info <NSObject>
@end

@interface Sub_Comment_Info : JSONModel
@property(nonatomic,strong)NSString *sub_id;
@property(nonatomic,strong)NSString *regid;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *other_id;
@property(nonatomic,strong)NSString *regtime;
@property(nonatomic,strong)NSString *regname;
@property(nonatomic,strong)NSString *other_name;
@end


@interface Seller_Seller_Comment_arr_comment_info : JSONModel
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *neat_praises;
@property(nonatomic,strong)NSString *descrip_praises;
@property(nonatomic,strong)NSString *regname;
@property(nonatomic,strong)NSArray <Optional,Sub_Comment_Info>*sub_comment;
@property(nonatomic,strong)NSString *praise_nums;
@property(nonatomic,strong)NSString *regid;
@property(nonatomic,strong)NSString *comment_id;
@property(nonatomic,strong)NSString *total_praises;
@property(nonatomic,strong)NSString *regtime;
@property(nonatomic,strong)NSString *attitude_praises;
@property(nonatomic,strong)NSString *content;
@end

@interface Seller_Seller_Comment_info : JSONModel 
@property(nonatomic,strong)NSArray<Seller_Seller_Comment_arr_comment_info> *arr_comment; 
@end

@interface Seller_Seller_Comment : JSONModel 
@property(nonatomic,strong)Seller_Seller_Comment_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end