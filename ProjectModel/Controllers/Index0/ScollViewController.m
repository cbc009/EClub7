//
//  ScollViewController.m
//  Bookkeeping
//
//  Created by macbook pro on 15/3/12.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "ScollViewController.h"
#import "SharedData.h"
@interface ScollViewController ()

@end

@implementation ScollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showIntroWithCrossDissolve];
    // Do any additional setup after loading the view.
}
- (void)showIntroWithCrossDissolve {
    NSLog(@"%f",DeviceFrame.size.height);
    NSArray *imgArray;
    if (DeviceFrame.size.height>568) {
        imgArray =@[@"1",@"2",@"3",@"4"];
    }else{
        imgArray =@[@"11",@"22",@"33",@"44"];
    }
    
    EAIntroPage *page1 = [EAIntroPage page];
//    page1.title = @"Hello world";
//    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:imgArray[0]];
//    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
//    page2.title = @"This is page 2";
//    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:imgArray[1]];
//    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
//    page3.title = @"This is page 3";
//    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:imgArray[2]];
//    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    EAIntroPage *page4 =[EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:imgArray[3]];
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}
- (void)introDidFinish {
   
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
