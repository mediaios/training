//
//  ViewController.m
//  MethodSwizzling
//
//  Created by ethan on 2019/4/17.
//  Copyright © mediaios. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *per = [[Person alloc] init];
    [per speak:@"English"];
    [per speak:@"Chinese"];
    
    [Person sleep:8];
    [Person sleep:5];
    
    NSMutableDictionary *mutaDict  = [NSMutableDictionary dictionary];
    [mutaDict setObject:@"hello" forKey:@"key1"];
    
}


@end
