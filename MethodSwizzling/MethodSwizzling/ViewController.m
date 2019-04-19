//
//  ViewController.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "UIButton+QuickClick.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *quickBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    [self test2];
    self.quickBtn.delayTime = 3;
    
    
    
    
    
}

- (void)test1
{
    Person *per = [[Person alloc] init];
    [per speak:@"English"];
    [per speak:@"Chinese"];
    
    [Person sleep:8];
    [Person sleep:5];
    
    NSMutableDictionary *mutaDict  = [NSMutableDictionary dictionary];
    [mutaDict setObject:@"hello" forKey:@"key1"];
}

- (void)test2
{
    NSArray *arr = @[@"a",@"b",@"c",@"d",@"e",@"f"];
    NSLog(@"atIndex方式： %@",[arr objectAtIndex:10]);
    NSLog(@"下标方式: %@",arr[10]);
}


- (IBAction)onPressedBtnQuickClick:(id)sender {
    NSLog(@"%s",__func__);
}




@end
