//
//  VSNewsPresenter.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "VSNewsPresenter.h"
#import "NewsCell.h"
#import "VSNewsModel.h"
#import "NewsCellModel.h"
#import "LoadingIndicatorCell.h"

@interface VSNewsPresenter ()
@property (weak, nonatomic) id <VSNewsViewProtocol> view;
@property (nonatomic) id <VSNewsModelProtocol> model;
@property NSMutableArray<NewsCellModel *> * cellModels;
@property BOOL isLoading;
@property NSString* start_from;
@property NSInteger pageSize;
@end

@implementation VSNewsPresenter

- (instancetype)initWithView:(id <VSNewsViewProtocol>) view
{
    self = [super init];
    if (self) {
        self.view = view;
        self.model = [[VSNewsModel alloc] initWithPresenter:self];
        self.cellModels = [NSMutableArray new];
        self.pageSize = 10;
    }
    return self;
}

#pragma mark VSNewsPresenterProtocol

- (void) viewDidLoad{
    self.isLoading = YES;
    [self.model loadNewsWithCount:self.pageSize startFrom:nil];
}

- (void) didLoadNewsPart:(NSArray<Newsfeed *> *)newsFeed startFrom: (NSString*) start_from{
    self.isLoading = NO;
    self.start_from = start_from;
    for (Newsfeed *feed in newsFeed) {
        [self.cellModels addObject:[[NewsCellModel alloc] initWithEntity:feed]];
    }
    [self.view reloadView];
}

- (void) didFailLoadNews:(NSError *)error{
    [self.view showError:error];
}

#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isLoading) {
        return self.cellModels.count+1;
    }
    return self.cellModels.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.cellModels.count) {
        LoadingIndicatorCell *cell = [[LoadingIndicatorCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == _cellModels.count - 1 && !self.isLoading) {
        self.isLoading = YES;
        [self.model loadNewsWithCount:self.pageSize startFrom:self.start_from];
    }
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    [self.cellModels[indexPath.row] fillCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) didClickOnCellWithIndex:(NSInteger) index{
    
}

@end
