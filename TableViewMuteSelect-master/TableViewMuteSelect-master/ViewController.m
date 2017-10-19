//
//  ViewController.m
//  TableViewMuteSelect-master
//
//  Created by iOSgo on 2017/10/19.
//  Copyright © 2017年 iOSgo. All rights reserved.
//

#import "ViewController.h"
#import "ViewDetailsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController {
    NSMutableArray *_rowAry;
    BOOL _isEditing;
    NSMutableArray *_selectAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _rowAry = [NSMutableArray array];
    _selectAry = [NSMutableArray array];
    for (int i=0; i<15; i++) {
        [_rowAry addObject:@(i)];
    }
    [self setupTableView];
    
    _isEditing = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editingCell)];
    
    
}

- (void)editingCell {
    
    _isEditing = !_isEditing;
    
    self.tableView.editing = _isEditing;
    
    if (_isEditing) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteCell)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}

- (void)deleteCell {
    
    for (id obj in _selectAry) {
        if ([_rowAry containsObject:obj]) {
            [_rowAry removeObject:obj];
        }
    }
    [self.tableView reloadData];
    
}

- (void)setupTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell%@",_rowAry[indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"detailTextLabel%@",_rowAry[indexPath.row]];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [_rowAry removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


//多选
//- (NSArray <UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏收藏收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//    }];
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//    }];
//    return @[deleteRowAction,collectRowAction];
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableView.isEditing) {
        
        if (![_selectAry containsObject:_rowAry[indexPath.row]]) {
            [_selectAry addObject:_rowAry[indexPath.row]];
        }
        
    } else {
        
        ViewDetailsViewController *vc = [[ViewDetailsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (self.tableView.isEditing) {
        
        if ([_selectAry containsObject:_rowAry[indexPath.row]]) {
            [_selectAry removeObject:_rowAry[indexPath.row]];
        }
        
    } else {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
