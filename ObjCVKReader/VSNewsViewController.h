//
//  VSNewsViewController.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSNewsViewProtocol <NSObject>
- (void) reloadView;
- (void) showError:(NSError*) error;
@end

@interface VSNewsViewController : UIViewController <VSNewsViewProtocol>
+ (VSNewsViewController *) instantiate;
@end
