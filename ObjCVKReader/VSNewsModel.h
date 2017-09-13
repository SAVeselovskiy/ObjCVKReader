//
//  VSNewsModel.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 11.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSNewsPresenter.h"

@protocol VSNewsModelProtocol <NSObject>
- (void) loadNewsWithCount: (NSInteger) count startFrom: (NSString*) startFrom;
- (instancetype)initWithPresenter:(id <VSNewsPresenterProtocol>) preseneter;
@end

@interface VSNewsModel : NSObject <VSNewsModelProtocol>

@end
