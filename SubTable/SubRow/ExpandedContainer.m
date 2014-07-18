//
//  ExpandedContainer.m
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import "ExpandedContainer.h"
#import "SubTableViewCell.h"

@implementation ExpandedContainer

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // SubTableViewCell *cell = (SubTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    // ...
    
    [self.delegate didSelectRowAtChildIndex:indexPath.row underParentIndex:self.parentIndex];
}

@end
