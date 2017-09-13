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
        [self.presenter didLoadNewsPart:result startFrom:response.json[@"next_from"]];
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
        feed.source_name = [self findSourceNameWithId:feed.source_id item:item groups:response[@"groups"] profiles:response[@"profiles"]];
        feed.source_photo = [self findSourcePhotoWithId:feed.source_id item:item groups:response[@"groups"] profiles:response[@"profiles"]];
        [news addObject:feed];
        
    }
    return news.copy;
}

- (NSString*) findSourceNameWithId: (long) source_id item: (NSDictionary*) item groups: (NSArray*) groups profiles: (NSArray*) profiles{
    if (source_id < 0) {
        source_id = source_id*(-1);
        groups = [groups filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject[@"id"] longValue] == source_id;
        }]];
        return groups.firstObject[@"name"];
    }
    else{
        profiles = [profiles filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject[@"id"] longValue] == source_id;
        }]];
        
        return [NSString stringWithFormat:@"%@ %@", profiles.firstObject[@"first_name"], profiles.firstObject[@"last_name"]];
    }
}

- (NSURL*) findSourcePhotoWithId: (long) source_id item: (NSDictionary*) item groups: (NSArray*) groups profiles: (NSArray*) profiles{
    NSArray *items;
    if (source_id < 0) {
        source_id = source_id*(-1);
        items = groups;
    }
    else{
        items = profiles;
    }
    items = [items filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject[@"id"] longValue] == source_id;
    }]];
    NSString* photoURL = items.firstObject[@"photo_50"];
    return [NSURL URLWithString:photoURL];
}

@end
