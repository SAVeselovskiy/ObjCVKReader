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
    NSString *likesString = [NSString stringWithFormat:@"%d", self.feed.likes_count];
    if (self.feed.likes_count > 1000) {
        double likeCount = (double)self.feed.likes_count/1000;
        likesString = [NSString stringWithFormat:@"%.02fK", likeCount];
    }
    cell.likeCountLabel.text = likesString;
    
    NSString *repostsString = [NSString stringWithFormat:@"%d", self.feed.reposts_count];
    if (self.feed.reposts_count > 1000) {
        double repostsCount = (double)self.feed.reposts_count/1000;
        repostsString = [NSString stringWithFormat:@"%.02fK", repostsCount];
    }
    cell.repostCountLabel.text = repostsString;
}

@end
