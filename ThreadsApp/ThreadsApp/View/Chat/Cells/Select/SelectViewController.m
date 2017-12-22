//
//  SelectViewController.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SelectViewController

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Design";
    
    [self configureTableView];
}

#pragma mark - Configure

- (void) configureTableView {
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0f;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selects.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    THRDesign design = [self.selects[indexPath.row] integerValue];
    cell.textLabel.text = [SelectCell designName: design];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCellDidSelect:)]) {
        THRDesign design = [self.selects[indexPath.row] integerValue];
        [self.delegate selectCellDidSelect: design];
    }
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
