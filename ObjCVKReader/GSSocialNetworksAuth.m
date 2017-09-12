//
//  GSSocialNetworksAuth.m
//  Geo4ME
//
//  Created by Александр Терентьев on 13.02.17.
//  Copyright © 2017 GradoService LLC. All rights reserved.
//

#import "VSSocialNetworksAuth.h"
#import "VKSdk.h"

static NSArray  * SCOPE = nil;
@interface VSSocialNetworksAuth  () <VKSdkDelegate, VKSdkUIDelegate>
@end

@implementation VSSocialNetworksAuth

-(instancetype) initWithPresenter:(UIViewController*) presenter{
    self = [super init];
    self.presenter = presenter;
    return self;
}

-(void) cleanClosures{
    _successClosure = nil;
    _failureClosure = nil;
}

- (void)signIn{
    SCOPE = @[VK_PER_EMAIL, VK_PER_OFFLINE];
    VKSdk * vkSdkInstance = [VKSdk initializeWithAppId:@"6181415"];
    [vkSdkInstance registerDelegate:self];
    [vkSdkInstance setUiDelegate:self];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        NSString* states = @"0: VKAuthorizationUnknown\n1: VKAuthorizationInitialized\n2: VKAuthorizationPending\n3: VKAuthorizationExternal\n4: VKAuthorizationSafariInApp\n5: VKAuthorizationWebview\n6: VKAuthorizationAuthorized\n7: VKAuthorizationError";
        if (state == VKAuthorizationInitialized) {
            [VKSdk authorize:SCOPE];
        } else if (state == VKAuthorizationAuthorized) {
            _successClosure();
        } else if (error) {
            // Some error happend, but you may try later
            _failureClosure (error);
            NSLog(@"signInVkPressed Error %@, state: %lu. Find your state:) :\n%@",error, (unsigned long)state, states);
        } else {
            NSLog(@"Not handled VKAuthorizationState: %lu, Find your state:) :\n%@", (unsigned long)state, states);
            _failureClosure (nil);
        }
    }];
}

#pragma mark - vk ui delegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.presenter presentViewController:controller animated:YES completion:nil];
}

/**
 Calls when user must perform captcha-check
 @param captchaError error returned from API. You can load captcha image from <b>captchaImg</b> property.
 After user answered current captcha, call answerCaptcha: method with user entered answer.
 */
- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"vkSdkNeedCaptchaEnter %@",captchaError);
}

#pragma mark - vk delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.error) {
        NSLog(@"vkSdkUserAuthorizationFailed %@",result.error);
        _failureClosure(result.error);
    } else {
        _successClosure();
    }
}

/**
 Notifies delegate about access error, mostly connected with user deauthorized application
 */
- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"vkSdkUserAuthorizationFailed");
    _failureClosure(nil);
}

@end
