//
//  VSNewsModel.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 11.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSNewsModel : NSObject
- (void) loadNewsWithCount: (NSInteger) count startFrom: (NSString*) startFrom;
@end
