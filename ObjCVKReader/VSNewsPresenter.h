//
//  VSNewsPresenter.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Newsfeed.h"

@protocol VSNewsPresenterProtocol <NSObject> //надо бы разделить по двум протоколам
- (void) viewDidLoad;
- (void) didLoadNewsPart: (NSArray<Newsfeed *>*) newsFeed;
- (void) didFailLoadNews:(NSError*) error;
@end

@interface VSNewsPresenter : NSObject <VSNewsPresenterProtocol, UITableViewDataSource>

@end
