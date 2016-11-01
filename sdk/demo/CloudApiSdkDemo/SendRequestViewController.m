//
//  SendRequestViewController.m
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/10/25.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "SendRequestViewController.h"
#import "ApiClient.h"
#import "ResultModel.h"

@interface SendRequestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *SendGetRequestBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendPostFormRequestBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendPostBytesRequestBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendPutBytesRequestBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendDeleteRequestBtn;

- (IBAction)SendGetRequestAction;
- (IBAction)SendPostFormRequestAction;
- (IBAction)SendPostBytesRequestAction;
- (IBAction)SendPutBytesRequestAction;
- (IBAction)SendDeleteRequestAction;



@end

@implementation SendRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}


- (IBAction)SendGetRequestAction {
    [[ApiClient instance] sendHttpGetDemo:10000094
                                      sex:@"boy"
                                      age:18
                          completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                  [[ResultModel instance] setResultString:[NSString stringWithFormat:@"----------------------------------------\nHttp Get Response object: \n----------------------------------------\n\n%@\n\n\n----------------------------------------\nHttp Get Response Body:\n----------------------------------------\n\n%@" , response , bodyString]];
                                  [self performSegueWithIdentifier:@"getResultSegue" sender:nil];
                              });

                          }];
    

}

- (IBAction)SendPostFormRequestAction {
    
    [[ApiClient instance] sendHttpPostFormDemo:10000094
                                           sex:@"boy"
                                           age:18
                               completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                  [[ResultModel instance] setResultString:[NSString stringWithFormat:@"----------------------------------------\nHttp Post Form Response object: \n----------------------------------------\n%@\n\n\n----------------------------------------\nHttp Post Form Response Body:\n----------------------------------------\n\n%@" , response , bodyString]];
                                  [self performSegueWithIdentifier:@"getResultSegue" sender:nil];
                              });
                              
                          }];
}

- (IBAction)SendPostBytesRequestAction {
    [[ApiClient instance] sendHttpPostBytesDemo:10000094
                                            age:18
                                           sign:@"Hello , I am so happy"
                          completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                  [[ResultModel instance] setResultString:[NSString stringWithFormat:@"----------------------------------------\nHttp Post bytes Response object: \n----------------------------------------\n\n%@\n\n\n----------------------------------------\nHttp Post bytes Response Body:\n----------------------------------------\n\n%@" , response , bodyString]];
                                  [self performSegueWithIdentifier:@"getResultSegue" sender:nil];
                              });
                              
                          }];
}

- (IBAction)SendPutBytesRequestAction {
    [[ApiClient instance] sendHttpPutBytesDemo:10000094
                                           age:18
                                          sign:@"Hello , I am so happy"
                               completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                        [[ResultModel instance] setResultString:[NSString stringWithFormat:@"----------------------------------------\nHttp Put bytes Response object: \n----------------------------------------\n\n%@\n\n\n----------------------------------------\nHttp Put bytes Response Body:\n----------------------------------------\n\n%@" , response , bodyString]];
                                        [self performSegueWithIdentifier:@"getResultSegue" sender:nil];
                                    });
                                    
                                }];
}

- (IBAction)SendDeleteRequestAction {
    [[ApiClient instance] sendHttpDeleteDemo:10000094
                                           age:18
                               completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                       [[ResultModel instance] setResultString:[NSString stringWithFormat:@"----------------------------------------\nHttp Delete Response object: \n----------------------------------------\n\n%@\n\n\n----------------------------------------\nHttp Delete Response Body:\n----------------------------------------\n\n%@" , response , bodyString]];
                                       [self performSegueWithIdentifier:@"getResultSegue" sender:nil];
                                   });
                                   
                               }];
}
@end
