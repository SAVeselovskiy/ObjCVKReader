//
//  VSNewsViewController.m
//  ObjCVKReader
//
//  Created by Сергей Веселовский on 12.09.17.
//  Copyright © 2017 Сергей Веселовский. All rights reserved.
//

#import "VSNewsViewController.h"
#import "VSNewsPresenter.h"

@interface VSNewsViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) id<VSNewsPresenterProtocol, UITableViewDataSource> presenter;
@end

@implementation VSNewsViewController

+ (VSNewsViewController *) instantiate{
    return [[UIStoryboard storyboardWithName:@"NewsList" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.presenter = [[VSNewsPresenter alloc] initWithView:self];
    [self.presenter viewDidLoad];
    self.tableView.dataSource = self.presenter;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void) reloadView{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark VSNewsViewProtocol

- (void) showError:(NSError *)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", @"") message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.presenter didClickOnCellWithIndex:indexPath.row];
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
