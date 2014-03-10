//
//  ViewController.h
//  iOSWebRequest
//
//  Created by Marcelo Sampaio on 3/3/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *option;
@property (weak, nonatomic) IBOutlet UITextField *urlTextString;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UITextView *resulttext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



// URL Request
@property (strong, nonatomic) NSMutableData *data;

@property (strong,nonatomic) NSMutableArray *moviesDownloaded;


@end
