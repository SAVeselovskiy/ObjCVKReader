//
//  GSSocialNetworksAuth.h
//  Geo4ME
//
//  Created by Александр Терентьев on 13.02.17.
//  Copyright © 2017 GradoService LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^VSSuccessSocialNetworksAuth)();
typedef void (^VSFailureSocialNetworksAuth)( NSError* __nullable error);


/// VK does THEFUCK not support completion closures. So we need store closures in this helper. Retain GSSocialNetworksAuth somethere and release after completion closures called
@interface VSSocialNetworksAuth : NSObject
@property (weak, nonatomic) UIViewController*  __nullable presenter;
@property VSSuccessSocialNetworksAuth __nullable successClosure;
@property VSFailureSocialNetworksAuth __nullable failureClosure;
- (instancetype _Nullable ) initWithPresenter:(UIViewController*_Nullable) presenter;
- (void)signIn;
- (void) cleanClosures;
@end
