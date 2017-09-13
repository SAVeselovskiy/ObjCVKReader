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
#import "NewsCellModel.h"

@interface VSNewsPresenter ()
@property (weak, nonatomic) id <VSNewsViewProtocol> view;
@property (nonatomic) id <VSNewsModelProtocol> model;
@property NSArray<NewsCellModel *> * cellModels;
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

#pragma mark VSNewsPresenterProtocol

- (void) viewDidLoad{
    [self.model loadNewsWithCount:10 startFrom:nil];
}

- (void) didLoadNewsPart:(NSArray<Newsfeed *> *)newsFeed{
    
}

- (void) didFailLoadNews:(NSError *)error{
    
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
