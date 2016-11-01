//
//  ShowResultViewController.m
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/10/25.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "ShowResultViewController.h"
#import "ResultModel.h"


@interface ShowResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *resultText;

@end

@implementation ShowResultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _resultText.text = [[ResultModel instance] resultString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
