//
//  VSNewsModel.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 11.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "VSNewsModel.h"
#import <VK-ios-sdk/VKSdk.h>
#import "Newsfeed.h"
#import "VSNewsPresenter.h"

@interface VSNewsModel ()
@property (weak, nonatomic) id <VSNewsPresenterProtocol> presenter;
@end

@implementation VSNewsModel

- (instancetype)initWithPresenter:(id <VSNewsPresenterProtocol>) preseneter
{
    self = [super init];
    if (self) {
        self.presenter = preseneter;
    }
    return self;
}

- (void) loadNewsWithCount: (NSInteger) count startFrom: (NSString*) startFrom{
    NSDictionary *params;
    if (startFrom) {
        params = @{@"filters":@"post", @"max_photos":@(1), @"count":@(count), @"start_from":startFrom};
    }
    else{
        params = @{@"filters":@"post", @"max_photos":@(1), @"count":@(count)};
    }
    VKRequest *req = [VKRequest requestWithMethod:@"newsfeed.get" parameters:params];
    [req executeWithResultBlock:^(VKResponse *response) {
        NSArray* result = [self parseNewsFeedResponse:response.json];
        [self.presenter didLoadNewsPart:result];
    } errorBlock:^(NSError *error) {
        [self.presenter didFailLoadNews:error];
    }];
}

- (NSArray*) parseNewsFeedResponse: (NSDictionary*)response{
    NSMutableArray *news = [NSMutableArray new];
    for (NSDictionary* item in response[@"items"]) {
        Newsfeed *feed = [Newsfeed new];
        feed.text = item[@"text"];
        feed.source_id = [item[@"source_id"] longValue];
        feed.date = [item[@"date"] doubleValue];
        feed.likes_count = [item[@"likes"][@"count"] integerValue];
        feed.reposts_count = [item[@"reposts"][@"count"] integerValue];
        feed.signer_id = item[@"signer_id"];
        feed.user_likes = [item[@"likes"][@"user_likes"] boolValue];
        feed.user_reposted = [item[@"reposts"][@"user_reposted"] boolValue];
        feed.post_id = [item[@"post_id"] longValue];
        
        NSArray *attachments = item[@"attachments"];
        attachments = [attachments filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject[@"type"] isEqualToString:@"photo"];
        }]];
        for (NSDictionary *photo in attachments) {
            NSString *photoUrl = photo[@"photo"][@"photo_604"];
            if (photoUrl){
                feed.photoURL = [NSURL URLWithString:photoUrl];
                break;
            }
        }
        feed.source_name = [self findSourceNameWithId:feed.source_id item:item];
        feed.source_photo = [self findSourcePhotoWithId:feed.source_id item:item];
        [news addObject:feed];
        
    }
    return news.copy;
}

- (NSString*) findSourceNameWithId: (long) source_id item: (NSDictionary*) item{
    if (source_id < 0) {
        NSArray *groups = item[@"groups"];
        groups = [groups filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject[@"id"] longValue] == source_id;
        }]];
        return groups.firstObject[@"name"];
    }
    else{
        NSArray *profiles = item[@"profiles"];
        profiles = [profiles filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject[@"id"] longValue] == source_id;
        }]];
        
        return [NSString stringWithFormat:@"%@ %@", profiles.firstObject[@"first_name"], profiles.firstObject[@"last_name"]];
    }
}

- (NSURL*) findSourcePhotoWithId: (long) source_id item: (NSDictionary*) item{
    NSArray *items;
    if (source_id < 0) {
        items = item[@"groups"];
    }
    else{
        items = item[@"profiles"];
    }
    items = [items filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject[@"id"] longValue] == source_id;
    }]];
    NSString* photoURL = items.firstObject[@"photo_50"];
    return [NSURL URLWithString:photoURL];
}

@end
