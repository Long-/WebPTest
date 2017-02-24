//
//  ViewController.m
//  WebPTest
//
//  Created by long_ on 17/2/15.
//  Copyright © 2017年 long_. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+WebPUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *jpgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2 - 5)];
    jpgImage.image = [UIImage imageNamed:@"wepImage"];
    [self.view addSubview:jpgImage];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
