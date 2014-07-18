# SubTable  
A lightweight subclass of UITableView with Expandable/Collapsable rows. Implemented by inserting a cell below an expanded parent cell to act as a container. The container is adjusted to fit the height of the combined row heights of all child row heights in the nested table view. Both the parent row and child row heights can be adjusted to suit your needs.

## Features  
* A UITableView subclass implemented using a second, nested table view
* Support for custom and independent row heights for parent and child table views
* Recycled cells for both parent and child table views, allowing for high performance at large numbers of parents and children
* Easy to plug in and customize to fit your project

## Examples  
This repo contains an example project optimized for iPhone to use as a template for testing purposes  
* SubTableExample.xcodeproj
![alt tag](https://github.com/ajkoshy7/SubTable/blob/master/SubTable.png)

## Usage  
The easiest way to install is by copying the SubTable directory to your project  
In your project:  
* Initialize a ParentTableView:
    `ParentTableView *vc = [[ParentTableView alloc] init];`
* Optionally, add a UITableView to your xib file and set its class to `ParentTableView`
* a
