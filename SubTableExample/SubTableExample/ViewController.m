//
//  ViewController.m
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import "ViewController.h"
#import "ParentTableView.h"
#import "ParentTableViewCell.h"
#import "SubTableView.h"
#import "SubTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"SubTable";
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView setDataSourceDelegate:self];
    [self.tableView setTableViewDelegate:self];
}



#pragma mark - SubTableViewDelegate

// @optional
- (void)tableView:(UITableView *)tableView didSelectCellAtChildIndex:(NSInteger)childIndex withInParentCellIndex:(NSInteger)parentIndex {
    // ...
}
- (void)tableView:(UITableView *)tableView didDeselectCellAtChildIndex:(NSInteger)childIndex withInParentCellIndex:(NSInteger)parentIndex {
    // ...
}
- (void)tableView:(UITableView *)tableView didSelectParentCellAtIndex:(NSInteger)parentIndex {
    // ..
}


#pragma mark - SubTableDataSource - Parent

// @required
- (NSInteger)numberOfParentCells {
    
    return 50;
}
- (NSInteger)heightForParentRows {
    
    return 75;
}

// @optional
- (NSString *)titleLabelForParentCellAtIndex:(NSInteger)parentIndex {
    
    return [NSString stringWithFormat:@"Parent %i",parentIndex + 1];
}
- (NSString *)subtitleLabelForParentCellAtIndex:(NSInteger)parentIndex {
    
    NSInteger childCount = [self numberOfChildCellsUnderParentIndex:parentIndex];
    if (childCount > 1)
        return [NSString stringWithFormat:@"%i children", (int)childCount];
    else if (childCount == 1)
        return [NSString stringWithFormat:@"%i child", (int)childCount];
    else
        return @"No children";
}



#pragma mark - SubTableDataSource - Child

// @required
- (NSInteger)numberOfChildCellsUnderParentIndex:(NSInteger)parentIndex {
    
    return 5;
}
- (NSInteger)heightForChildRows {
    
    return 55;
}

// @optional
- (NSString *)titleLabelForCellAtChildIndex:(NSInteger)childIndex withinParentCellIndex:(NSInteger)parentIndex {
    
    return [NSString stringWithFormat:@"Child %i",childIndex + 1];
}
- (NSString *)subtitleLabelForCellAtChildIndex:(NSInteger)childIndex withinParentCellIndex:(NSInteger)parentIndex {
    
    return [NSString stringWithFormat:@"nested under parent %i",parentIndex + 1];
}

@end
