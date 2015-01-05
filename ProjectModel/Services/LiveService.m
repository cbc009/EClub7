//
//  LiveService.m
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "LiveService.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "LiveModel.h"
@implementation LiveService
-(void)loadLiveDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type onLiveViewController:(LiveViewController *)viewController
{
    
    NSString *urlString = [NSString stringWithFormat:LiveURL,token,user_type];
    [LiveModel getModelFromURLWithString:urlString completion:^(LiveModel *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        if (model.status == 2) {
            viewController.datas = (NSMutableArray *)model.info.data;
            //label_height 发布信息的label高度
            //label1_height 回复信息的label高度
            //labeAddheight 回复信息的总label高度
            //tableViewheight tableView 的高度
            
            for (int i=0; i<viewController.datas.count; i++) {
                CGFloat tableViewheight = 0.0;
                CGFloat label_height = 0.0;
                CGFloat label1_height = 0.0;
                CGFloat labeAddheight= 0.0;
                DataInfo *data = viewController.datas[i];
                NSInteger h = [data.content length]/19;
                if (h==0) {
                    label_height = 20;
                }else{
                    label_height = h*22+20;
                }if (data.comment.count>0) {
                    for (int k=0; k<data.comment.count; k++) {
//                        CommentInfo *comment = data.comment[k];
                        NSInteger j = [data.content length]/19;
                        if (j==0) {
                            label1_height = 20;
                        }else{
                            label1_height = j*22+20;
                        }
                        labeAddheight = labeAddheight+label1_height;
                        [viewController.heightArray addObject:[NSString stringWithFormat:@"%f",label1_height]];
                    }
                    tableViewheight =labeAddheight +80;

                }else{
                    tableViewheight = 20;
                }
                [viewController.tableViewheightArray addObject:[NSString stringWithFormat:@"%f",tableViewheight]];
               [viewController.cellHeightlArray addObject:[NSString stringWithFormat:@"%f",label_height+tableViewheight+80]];
                [viewController.labeHeightlArray addObject:[NSString stringWithFormat:@"%f",label_height]];
            }
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        } else{
            NSLog(@"error");
            [SVProgressHUD dismiss];
        }
    }];
}

@end
