//
//  VSNewsPresenter.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol VSNewsPresenterProtocol <NSObject>
- (void) viewDidLoad;
@end

@interface VSNewsPresenter : NSObject <VSNewsPresenterProtocol, UITableViewDataSource>

@end
