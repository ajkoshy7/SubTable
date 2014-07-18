//
//  ParentTableView.m
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import "ParentTableView.h"
#import "ParentTableViewCell.h"
#import "ExpandedContainer.h"

@interface ParentTableView () {
    
    ParentTableViewCell *previouslySelectedCell;
}

@end

@implementation ParentTableView
@synthesize tableViewDelegate, expansionStates;

- (id)initWithFrame:(CGRect)frame dataSource:dataDelegate tableViewDelegate:tableDelegate {
    
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}
- (void)initialize {
    
    [self setDataSource:self];
    [self setDelegate:self];
    
    self.backgroundColor = [UIColor colorWithWhite:( 20/255.0) alpha:1.0];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.separatorColor = [UIColor darkGrayColor];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableFooterView = footer;
}



#pragma mark - Configuration

- (id)getDataSourceDelegate {
    
    return dataSourceDelegate;
}
- (void)setDataSourceDelegate:(id)deleg {
    
    dataSourceDelegate = deleg;
    [self initExpansionStates];
}
- (void)initExpansionStates {
    
    expansionStates = [[NSMutableArray alloc] initWithCapacity:[self.dataSourceDelegate numberOfParentCells]];
    for(int i = 0; i < [self.dataSourceDelegate numberOfParentCells]; i++) {
        [expansionStates addObject:@"NO"];
    }
}



#pragma mark - Table Interaction

- (void)expandForParentAtRow:(NSInteger)row {
    
    NSUInteger parentIndex = [self parentIndexForRow:row];
    
    if ([[self.expansionStates objectAtIndex:parentIndex] boolValue]) {
        return;
    }
    
    // update expansionStates so backing data is ready before calling insertRowsAtIndexPaths
    [self.expansionStates replaceObjectAtIndex:parentIndex withObject:@"YES"];
    [self insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:(row + 1) inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)collapseForParentAtRow:(NSInteger)row {
    
    if (![self.dataSourceDelegate numberOfParentCells] > 0) {
        return;
    }
    
    NSUInteger parentIndex = [self parentIndexForRow:row];
    
    if (![[self.expansionStates objectAtIndex:parentIndex] boolValue]) {
        return;
    }
    
    // update expansionStates so backing data is ready before calling deleteRowsAtIndexPaths
    [self.expansionStates replaceObjectAtIndex:parentIndex withObject:@"NO"];
    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:(row + 1) inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)collapseAllRows {
    
    if ([self.expansionStates containsObject:@"YES"]) {
        
        NSInteger row = [self.expansionStates indexOfObject:@"YES"];
        
        [self.expansionStates replaceObjectAtIndex:row withObject:@"NO"];
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:(row + 1) inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}



#pragma mark - Table Information

- (NSUInteger)rowForParentIndex:(NSUInteger)parentIndex {
    
    NSUInteger row = 0;
    NSUInteger currentParentIndex = 0;
    
    if (parentIndex == 0) {
        return 0;
    }
    
    while (currentParentIndex < parentIndex) {
        BOOL expanded = [[self.expansionStates objectAtIndex:currentParentIndex] boolValue];
        if (expanded) {
            row++;
        }
        currentParentIndex++;
        row++;
    }
    return row;
}
- (NSUInteger)parentIndexForRow:(NSUInteger)row {
    
    NSUInteger parentIndex = -1;

    NSUInteger i = 0;
    while (i <= row) {
        parentIndex++;
        i++;
        if ([[self.expansionStates objectAtIndex:parentIndex] boolValue]) {
            i++;
        }
    }
    return parentIndex;
}
- (BOOL)isExpansionCell:(NSUInteger)row {
    
    if (row < 1) {
        return NO;
    }
    NSUInteger parentIndex = [self parentIndexForRow:row];
    NSUInteger parentIndex2 = [self parentIndexForRow:(row-1)];
    return (parentIndex == parentIndex2);
}



#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger rowHeight = [self.dataSourceDelegate heightForParentRows];
    
    BOOL isExpansionCell = [self isExpansionCell:row];
    if (isExpansionCell) {
        
        NSInteger parentIndex = [self parentIndexForRow:row];
        NSInteger numberOfChildren = [self.dataSourceDelegate numberOfChildCellsUnderParentIndex:parentIndex];
        NSInteger childRowHeight = [self.dataSourceDelegate heightForChildRows];
        return childRowHeight * numberOfChildren;
    }
    else
        return rowHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (![self.dataSourceDelegate numberOfParentCells] > 0) {
        return 0;
    }
    
    // returns sum of parent cells and expanded cells
    NSInteger parentCount = [self.dataSourceDelegate numberOfParentCells];
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:self.expansionStates];
    NSUInteger expandedParentCount = [countedSet countForObject:@"YES"];
    
    return parentCount + expandedParentCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PARENT_IDENTIFIER = @"CellReuseId_Parent";
    static NSString *CHILD_CONTAINER_IDENTIFIER = @"CellReuseId_Container";
    
    NSInteger row = indexPath.row;
    NSUInteger parentIndex = [self parentIndexForRow:row];
    BOOL isParentCell = ![self isExpansionCell:row];
    
    if (isParentCell) {
        
        ParentTableViewCell *cell = (ParentTableViewCell *)[self dequeueReusableCellWithIdentifier:PARENT_IDENTIFIER];
        if (cell == nil) {
            cell = [[ParentTableViewCell alloc] initWithReuseIdentifier:PARENT_IDENTIFIER];
        }
        
        cell.titleLabel.text = [self.dataSourceDelegate titleLabelForParentCellAtIndex:parentIndex];
        [cell.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
        
        cell.subtitleLabel.text = [self.dataSourceDelegate subtitleLabelForParentCellAtIndex:parentIndex];
        [cell.subtitleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [cell setCellForegroundColor:[UIColor whiteColor]];
        [cell setCellBackgroundColor:[UIColor colorWithWhite:( 30/255.0) alpha:1.0]];
        [cell setParentIndex:parentIndex];
        cell.tag = parentIndex;
        
        [self deselectCell:cell];
        if ([[self.expansionStates objectAtIndex:[cell parentIndex]] boolValue])
            [self selectCell:cell];
        
        return cell;
    }
    else {
        
        ExpandedContainer *cell = (ExpandedContainer *)[self dequeueReusableCellWithIdentifier:CHILD_CONTAINER_IDENTIFIER];
        if (cell == nil) {
            cell = [[ExpandedContainer alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CHILD_CONTAINER_IDENTIFIER];
        }
        
        [cell setSubTableForegroundColor:[UIColor whiteColor]];
        [cell setSubTableBackgroundColor:[UIColor colorWithWhite:( 30/255.0) alpha:1.0]];
        [cell setParentIndex:parentIndex];
        
        [cell setDelegate:self];
        [cell reload];
        
        return cell;
    }
}



#pragma mark - Table view - Cell Selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedPCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedPCell isKindOfClass:[ParentTableViewCell class]]) {
        
        ParentTableViewCell *pCell = (ParentTableViewCell *)selectedPCell;
        self.selectedRow = [pCell parentIndex];
        
        if ([[self.expansionStates objectAtIndex:[pCell parentIndex]] boolValue]) {
            
            // clicked an already expanded cell
            [self collapseForParentAtRow:indexPath.row];
            [self deselectCell:pCell];
            previouslySelectedCell = nil;
        }
        else {
            
            // clicked a collapsed cell
            [self collapseAllRows];
            [self expandForParentAtRow:[pCell parentIndex]];
            
            [self deselectCell:previouslySelectedCell];
            previouslySelectedCell = pCell;
            [self selectCell:previouslySelectedCell];
        }
        
        if ([self.tableViewDelegate respondsToSelector:@selector(tableView:didSelectParentCellAtIndex:)]) {
            [self.tableViewDelegate tableView:tableView didSelectParentCellAtIndex:[pCell parentIndex]];
        }
    }
}
- (void)selectCell:(ParentTableViewCell *)cell {
    
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.subtitleLabel.textColor = [UIColor colorWithWhite:0.98 alpha:1.0];
}
- (void)deselectCell:(ParentTableViewCell *)cell {
    
    cell.titleLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    cell.subtitleLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
}



# pragma mark - TableView - Section

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"click to expand";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *oldSectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    NSString *sectionTitle = [NSString stringWithFormat:@"   %@",oldSectionTitle];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 320, 30);
    label.backgroundColor = [UIColor colorWithWhite:( 20/255.0) alpha:1.0];
    label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(-1.0, 1.0);
    label.font = [UIFont systemFontOfSize:17];
    label.text = sectionTitle;
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 28, 320, 2)];
    bottomLine.backgroundColor = [UIColor colorWithWhite:( 50/255.0) alpha:1.0];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    [view addSubview:bottomLine];
    
    return view;
}



#pragma mark - SubRow Delegate

// @required
- (NSInteger)numberOfChildrenUnderParentIndex:(NSInteger)parentIndex {
    
    return [self.dataSourceDelegate numberOfChildCellsUnderParentIndex:parentIndex];
}
- (NSInteger)heightForChildRows {
    
    return [self.dataSourceDelegate heightForChildRows];
}

// @optional
- (void)didSelectRowAtChildIndex:(NSInteger)childIndex
                underParentIndex:(NSInteger)parentIndex {
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[self rowForParentIndex:parentIndex] inSection:0];
    UITableViewCell *selectedCell = [self cellForRowAtIndexPath:indexPath];
    if ([selectedCell isKindOfClass:[ParentTableViewCell class]]) {
        
        // ParentTableViewCell * pCell = (ParentTableViewCell *)selectedCell;
        
        // Insert code here to detect and handle child cell selection
        // ...
    }
}
- (NSString *)titleLabelForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex {
    
    return [self.dataSourceDelegate titleLabelForCellAtChildIndex:childIndex withinParentCellIndex:parentIndex];
}
- (NSString *)subtitleLabelForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex {
    
    return [self.dataSourceDelegate subtitleLabelForCellAtChildIndex:childIndex withinParentCellIndex:parentIndex];
}

@end
