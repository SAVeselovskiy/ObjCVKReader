//
//  NewsCellModel.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "NewsCellModel.h"

@interface NewsCellModel()
@property Newsfeed *feed;
@end

@implementation NewsCellModel
- (instancetype)initWithEntity:(Newsfeed*) feed
{
    self = [super init];
    if (self) {
        self.feed = feed;
    }
    return self;
}


- (void) fillCell:(NewsCell *)cell{
    cell.feedTextLabel.text = self.feed.text;
    cell.authorName.text = self.feed.source_name;
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.feed.likes_count];
    cell.repostCountLabel.text = [NSString stringWithFormat:@"%d", self.feed.reposts_count];
    
}

@end
