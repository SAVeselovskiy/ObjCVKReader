//
//  NewsCellModel.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCell.h"
#import "Newsfeed.h"

@interface NewsCellModel : NSObject
- (void) fillCell:(NewsCell*) cell;
@end
