//
//  Newsfeed.h
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 11.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Newsfeed : NSObject
@property long source_id;
@property NSTimeInterval date;
@property NSString *text;
@property NSInteger likes_count;
@property NSInteger reposts_count;
@property NSURL *photoURL;
@property NSNumber* signer_id;
@property BOOL user_likes;
@property BOOL user_reposted;
@property long post_id;
@property NSString *source_name;
@property NSURL *source_photo;
@end
