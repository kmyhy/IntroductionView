//
//  IntroductionView.m
//  IntroductionView
//
//  Created by qq on 2017/10/11.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "IntroductionView.h"

@implementation Tile

-(instancetype)initWithImageName:(NSString*)name frame:(CGRect)frame/* touchable:(BOOL)touchable*/{
    if(self = [super init]){
        self.imageName = name;
        self.frame = frame;
//        self.touchable = touchable;
    }
    return self;
}
@end;

@interface IntroductionView()
@end;
@implementation IntroductionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        // 设置遮罩层默认的背景色（透明度）
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.75];
        self.userInteractionEnabled = YES;
    }
    return  self;
}
-(void) removeWithCompletion:(void(^)(void))block
{
    if(self.alpha == 1){
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if(block) block();
        }];
    }
}
// 每当数据源改变，调用 reload 方法
-(void)setDataSource:(id<IntroductionViewDataSource>)dataSource{
    _dataSource = dataSource;
    [self reload];
}
// 数据源刷新方法
-(void)reload{
    if(_dataSource){
        for(UIView* v in self.subviews){// 删除所有 subviews
            [v removeFromSuperview];
        }
        NSArray<Tile*>* tiles = [_dataSource tilesForIntroductionView:self];
        for(int i=0;i<tiles.count;i++){
            Tile* tile = tiles[i];
            UIImageView *iv = [[UIImageView alloc]initWithFrame:tile.frame];
            iv.tag = i;
            iv.image = [UIImage imageNamed: tile.imageName];
            
//            if(tile.touchable){
                iv.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tileClicked:)];
                [iv addGestureRecognizer:singleTap];
//            }
            
            [self addSubview:iv];
        }
    }
}
// tile 点击事件处理
-(void)tileClicked:(UIGestureRecognizer*)gesture{
    int index = (int)gesture.view.tag;
    if(_dataSource){
        [_dataSource introductionView:self clickAtIndex:index];
    }
}
@end
