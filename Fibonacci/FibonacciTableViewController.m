//
//  FibonacciTableViewController.m
//  Fibonacci
//
//  Created by MIYAMOTO Shohei on 8/30/14.
//  Copyright (c) 2014 Miyamoto Shohei. All rights reserved.
//

#import "FibonacciTableViewController.h"

#import "FibonacciGenerator.h"
#import "FibonacciTableViewCell.h"

static NSString * const FibonacciTableViewControllerCellIdentifier = @"FibonacciTableViewControllerCellIdentifier";


@interface FibonacciTableViewController ()
@property (nonatomic, strong) FibonacciGenerator *generator;
@property (nonatomic, strong) FibonacciTableViewCell *prototypeCell;
@property (nonatomic, strong) NSCache *heightCache;
@end

@implementation FibonacciTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Infinite Fibonacci Calculator";

    self.generator = [FibonacciGenerator new];
    [self.generator generateTo:50];

    self.heightCache = [NSCache new];

    UINib *nib = [UINib nibWithNibName:@"FibonacciTableViewCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:FibonacciTableViewControllerCellIdentifier];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height == 0) {
        return;
    }

    if (scrollView.contentSize.height < scrollView.frame.size.height + scrollView.contentOffset.y) {
        [self.generator generateTo:self.generator.count + 50];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.generator.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FibonacciTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FibonacciTableViewControllerCellIdentifier
                                                                   forIndexPath:indexPath];
    [self configureCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *cached = [self.heightCache objectForKey:@(indexPath.row)];
    if (cached) {
        return [cached floatValue];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *cached = [self.heightCache objectForKey:@(indexPath.row)];
    if (cached) {
        return [cached floatValue];
    }

    self.prototypeCell.bounds = ({
        CGRect b = self.prototypeCell.bounds;
        b.size.width = tableView.frame.size.width;
        b;
    });
    self.prototypeCell.label.preferredMaxLayoutWidth = self.prototypeCell.label.frame.size.width;

    [self configureCell:self.prototypeCell indexPath:indexPath];
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat height = size.height + 1;

    [self.heightCache setObject:@(height)
                         forKey:@(indexPath.row)];
    return height;
}

#pragma mark -

- (void)configureCell:(FibonacciTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    cell.label.text = [self.generator fibonacciDescriptionAt:indexPath.row];
    cell.label.numberOfLines = 0;
    cell.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (FibonacciTableViewCell *)prototypeCell
{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:FibonacciTableViewControllerCellIdentifier];
    }
    return _prototypeCell;
}

#pragma mark - Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation
                                            duration:duration];
    [self.heightCache removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - UIContentSizeCategoryDidChangeNotification

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
    [self.heightCache removeAllObjects];
    [self.tableView reloadData];
}

@end
