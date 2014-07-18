//
//  ParentTableView.h
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandedContainer.h"

@class ViewController;

@protocol SubTableViewDelegate <NSObject>

@optional
- (void)tableView:(UITableView *)tableView didSelectCellAtChildIndex:(NSInteger)childIndex withInParentCellIndex:(NSInteger)parentIndex;
- (void)tableView:(UITableView *)tableView didDeselectCellAtChildIndex:(NSInteger)childIndex withInParentCellIndex:(NSInteger)parentIndex;
- (void)tableView:(UITableView *)tableView didSelectParentCellAtIndex:(NSInteger)parentIndex;

@end



@protocol SubTableViewDataSource <NSObject>

@required
- (NSInteger)numberOfParentCells;
- (NSInteger)numberOfChildCellsUnderParentIndex:(NSInteger)parentIndex;
- (NSInteger)heightForParentRows;
- (NSInteger)heightForChildRows;

@optional

// Parent DataSource
- (NSString *)titleLabelForParentCellAtIndex:(NSInteger)parentIndex;
- (NSString *)subtitleLabelForParentCellAtIndex:(NSInteger)parentIndex;

// Child DataSource
- (NSString *)titleLabelForCellAtChildIndex:(NSInteger)childIndex withinParentCellIndex:(NSInteger)parentIndex;
- (NSString *)subtitleLabelForCellAtChildIndex:(NSInteger)childIndex withinParentCellIndex:(NSInteger)parentIndex;

@end



@interface ParentTableView : UITableView
    <UITableViewDataSource, UITableViewDelegate, SubTableViewCellDelegate> {
    __weak id tableViewDelegate;
    __weak id dataSourceDelegate;
    NSMutableArray * expansionStates;
}

@property (nonatomic, weak) id<SubTableViewDelegate> tableViewDelegate;
@property (nonatomic, weak, getter = getDataSourceDelegate, setter = setDataSourceDelegate:) id<SubTableViewDataSource> dataSourceDelegate;
@property (nonatomic, strong) NSMutableArray * expansionStates;

@property (assign, nonatomic) NSInteger selectedRow;
- (void)collapseAllRows;

@end
