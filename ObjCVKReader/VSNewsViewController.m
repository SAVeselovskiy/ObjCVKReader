//
//  VSNewsViewController.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "VSNewsViewController.h"
#import "VSNewsPresenter.h"

@interface VSNewsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) id<VSNewsPresenterProtocol, UITableViewDataSource> presenter;
@end

@implementation VSNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.presenter = [[VSNewsPresenter alloc] init];
    [self.presenter viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) reloadView{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
