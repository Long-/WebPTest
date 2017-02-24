//
//  main.m
//  WebPTest
//
//  Created by long_ on 17/2/15.
//  Copyright © 2017年 long_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "UIImage+WebPUtils.h"
#import "ViewController.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        Method imageNamed          = class_getClassMethod([UIImage class], @selector(imageNamed:));
        Method webImageNamed = class_getClassMethod([UIImage class], @selector(pa_imageNamed:));
        method_exchangeImplementations(imageNamed, webImageNamed);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
