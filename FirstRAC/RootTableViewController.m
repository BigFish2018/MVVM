//
//  RootTableViewController.m
//  FirstRAC
//
//  Created by DaYu on 2019/4/24.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "RootTableViewController.h"
#import "ViewController.h"
#import "NormalViewController.h"
#import "RACSubjectDemoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>s

@interface RootTableViewController ()

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * identifier= @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if(indexPath.row==0){
        cell.textLabel.text = @"基本用法";
        cell.detailTextLabel.text = @"";
    }
    else if(indexPath.row==1){
        cell.textLabel.text = @"RAC定时器";
        cell.detailTextLabel.text = @"";
    }
    else if(indexPath.row==2){
        cell.textLabel.text = @"RACSubject和RACReplaySubject用法";
        cell.detailTextLabel.text = @"";
    }
    else if(indexPath.row==3){
        cell.textLabel.text = @"RACMulticastConnection";
        cell.detailTextLabel.text = @"";
    }
    else if(indexPath.row==4){
        cell.textLabel.text = @"RACCommand";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController * normalVC = [story instantiateViewControllerWithIdentifier:@"NormalVC"];
        //由navigationController推向我们要推向的view
        [self.navigationController pushViewController:normalVC animated:YES];
    }
    else if(indexPath.row == 1){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *timerVC = [story instantiateViewControllerWithIdentifier:@"TimerVC"];
        //由navigationController推向我们要推向的view
        [self.navigationController pushViewController:timerVC animated:YES];
    }
    else if(indexPath.row == 2){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *subjectVC = [story instantiateViewControllerWithIdentifier:@"RACSubjectVC"];
        //由navigationController推向我们要推向的view
        [self.navigationController pushViewController:subjectVC animated:YES];
    }
    else if(indexPath.row == 3){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController * networkVC = [story instantiateViewControllerWithIdentifier:@"RACNetwork"];
        //由navigationController推向我们要推向的view
        [self.navigationController pushViewController:networkVC animated:YES];
    }
    else if(indexPath.row == 4){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController * commandVC = [story instantiateViewControllerWithIdentifier:@"RACCommandVC"];
        //由navigationController推向我们要推向的view
        [self.navigationController pushViewController:commandVC animated:YES];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
