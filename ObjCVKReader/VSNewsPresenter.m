//
//  VSNewsPresenter.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "VSNewsPresenter.h"
#import "VSNewsViewController.h"
#import "NewsCell.h"
#import "VSNewsModel.h"

@interface VSNewsPresenter ()
@property (weak, nonatomic) id <VSNewsViewProtocol> view;
@property (nonatomic) id <VSNewsModelProtocol> model;
@end

@implementation VSNewsPresenter

- (instancetype)initWithView:(id <VSNewsViewProtocol>) view
{
    self = [super init];
    if (self) {
        self.view = view;
        self.model = [[VSNewsModel alloc] init];
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    return cell;
}

@end
