//
//  VSVKAuthenticator.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 11.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <VK-ios-sdk/VKSdk.h>

typedef void (^VSSuccessSocialNetworksAuth)(VKAccessToken * _Nullable token);
typedef void (^VSFailureSocialNetworksAuth)( NSError* __nullable error);

@interface VSVKAuthenticator : NSObject
@property (weak, nonatomic) UIViewController*  __nullable presenter;
@property VSSuccessSocialNetworksAuth __nullable successClosure;
@property VSFailureSocialNetworksAuth __nullable failureClosure;
- (instancetype _Nullable ) initWithPresenter:(UIViewController*_Nullable) presenter;
- (void)signIn;
- (void) cleanClosures;
@end
