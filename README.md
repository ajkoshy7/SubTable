# SubTable  
A lightweight subclass of UITableView with Expandable/Collapsible rows. Implemented by inserting a cell below an expanded parent cell to act as a container. The container is adjusted to fit the height of the combined row heights of all child row heights in the nested table view. Both the parent row and child row heights can be adjusted to suit your needs.

## Features  
* A UITableView subclass implemented using a second, nested table view
* Support for custom and independent row heights for parent and child table views
* Recycled cells for both parent and child table views, allowing for high performance at large numbers of parents and children
* Easy to plug in and customize to fit your project

## Examples  
This repo contains an example project optimized for iPhone to use as a template for testing purposes  

![alt tag](https://github.com/ajkoshy7/SubTable/blob/master/SubTable@2x.png)

## Usage  
The easiest way to install is by copying the SubTable directory to your project:  
Initialize a ParentTableView:
```objective-c
ParentTableView *tableView = [[ParentTableView alloc] init];
```
Optionally, add a UITableView to your xib file and set its class to `ParentTableView`  
Set your ViewController as it's delegate using:
```objective-c
self.tableView setDataSourceDelegate:self];
[self.tableView setTableViewDelegate:self];
```
Implement the following required delegate methods in your ViewController:
```objective-c
- (NSInteger)numberOfParentCells;
- (NSInteger)heightForParentRows;
- (NSInteger)numberOfChildCellsUnderParentIndex:(NSInteger)parentIndex;
- (NSInteger)heightForChildRows;
```
## License

Copyright (c) 2014 Alex Koshy ajkoshy7@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
