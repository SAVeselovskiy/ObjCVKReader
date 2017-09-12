//
//  LoginViewController.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 11.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "LoginViewController.h"
#import "VSVKAuthenticator.h"
#import <VK-ios-sdk/VKSdk.h>
#import "VSNewsModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)authAction:(id)sender {
    VSVKAuthenticator *vkAuthenticator = [[VSVKAuthenticator alloc] initWithPresenter:self];
    vkAuthenticator.failureClosure = ^(NSError * _Nullable error) {
        NSLog(@"Failure");
    };
    vkAuthenticator.successClosure = ^(VKAccessToken * _Nullable token) {
//        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"VKAccessToken"];
        
        [[VSNewsModel new] loadNewsWithCount:10 startFrom:nil];
    };
    [vkAuthenticator signIn];
//    [vkAuthenticator cleanClosures];
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
