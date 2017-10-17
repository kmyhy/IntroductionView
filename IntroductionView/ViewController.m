//
//  ViewController.m
//  IntroductionView
//
//  Created by qq on 2017/10/11.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ViewController.h"
#import "IntroductionView.h"
#import "AppDelegate.h"

@interface ViewController ()<IntroductionViewDataSource>
@property(nonatomic,retain)IntroductionView* introView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
/// 动态方式添加 introView
-(IntroductionView*)introView{
    if(!_introView){
        _introView = [[IntroductionView alloc]initWithFrame:self.view.bounds];
        _introView.dataSource = self;
    }
    return _introView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    AppDelegate* appDele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDele.window addSubview:self.introView];
    
}
- (CGRect)getTabBarItemFrameWithCount:(NSInteger)count index:(NSInteger)index
{
    NSInteger i = 0;
    CGRect itemFrame = CGRectZero;
    for (UIView *view in self.tabBarController.tabBar.subviews) {
        if (![NSStringFromClass([view class]) isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        //找到指定的tabBarItem
        if (index == i++) {
            itemFrame = view.frame;
            break;
        }
    }
    
    return itemFrame;
}
// MARK: - IntroductionViewDataSource
-(NSArray<Tile*>*)tilesForIntroductionView:(IntroductionView *)introView{
    NSMutableArray* mArr = [NSMutableArray new];
    // 1. 添加图片 masking_tags3
    // 获取 tabBarButton 的 frame
    CGRect itemFrame = [self getTabBarItemFrameWithCount:self.tabBarController.tabBar.items.count index:0];
    // 坐标转换，从 tabBar 坐标转换到 self.view  的坐标
    itemFrame = [self.tabBarController.tabBar convertRect:itemFrame toView:self.view];
    
    CGRect r = CGRectMake(0, 0, 114/2, 114/2);// 等于图片大小
    // 和 tabBarButton 水平居中，底端对齐
    r.origin.x = itemFrame.origin.x+(itemFrame.size.width - r.size.width)/2;
    r.origin.y = CGRectGetMaxY(itemFrame)-r.size.height;
    [mArr addObject:[[Tile alloc]initWithImageName:@"masking_tags3" frame:r]];
    
    // 2. 添加图片 masking_tags2，其左边对齐 masking_tag3，大小等于原图
    r = CGRectMake(r.origin.x, r.origin.y-192/2, 338/2, 192/2);
    [mArr addObject:[[Tile alloc]initWithImageName:@"masking_tags2" frame:r]];
    
    // 3. 添加图片 masking_btn，位于 masking_tags2 上方，水平居中，大小等于原图
    r.size.width = 236/2;
    r.size.height = 120/2;
    r.origin.x = (self.view.frame.size.width - r.size.width)/2;
    r.origin.y = r.origin.y - r.size.height-60;
    [mArr addObject:[[Tile alloc]initWithImageName:@"masking_btn" frame:r]];
    
    // 4. 添加图片 masking_tags1，大小等于原图，位于 masking_btn 上方，屏幕水平居中
    r.size.width = 446/2;
    r.size.height = 406/2;
    r.origin.x = (self.view.frame.size.width - r.size.width)/2;
    r.origin.y = r.origin.y - r.size.height-20;
    [mArr addObject:[[Tile alloc]initWithImageName:@"masking_tags1" frame:r]];
    
    return mArr;
}
-(void)introductionView:(IntroductionView *)introView clickAtIndex:(int)index{
    if(index == 2){
        __weak __typeof(self) weakSelf = self;
        [self.introView removeWithCompletion:^{
            weakSelf.introView = nil;
        }];
    }
}
@end
