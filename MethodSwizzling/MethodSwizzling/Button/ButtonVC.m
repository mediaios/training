//
//  ButtonVC.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "ButtonVC.h"

@interface ButtonVC ()
@property (nonatomic,assign) NSUInteger btnWidth;
@property (nonatomic,assign) NSUInteger btnHeight;
@end

@implementation ButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
}

- (IBAction)onPressedBtnDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onBressedBtnBig:(id)sender {
    NSArray *views = [self.view subviews];
    for (int i = 0; i < views.count; i++) {
        if ([views[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn  = views[i];
            [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width+20, btn.frame.size.height+20)];
        }
    }
}

- (IBAction)onPressedBtnSmall:(id)sender {
    NSArray *views = [self.view subviews];
    for (int i = 0; i < views.count; i++) {
        if ([views[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn  = views[i];
            [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width-20, btn.frame.size.height-20)];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
