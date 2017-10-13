//
//  IntroductionView.h
//  IntroductionView
//
//  Created by qq on 2017/10/11.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntroductionView;

@interface Tile:NSObject
@property(nonatomic,copy)NSString* imageName;
@property(nonatomic,assign)CGRect frame;
//@property(nonatomic,assign)BOOL touchable;// 是否可点击
-(instancetype)initWithImageName:(NSString*)name frame:(CGRect)frame;
@end

// 数据源委托协议
@protocol IntroductionDataSource<NSObject>
// 提供要添加的瓦片（UIView）集合
-(NSArray<Tile*>*)tilesForIntroductionView:(IntroductionView*)introView;
// 瓦片点击回调
-(void)introductionView:(IntroductionView*)introView clickAtIndex:(int)index;
@end

@interface IntroductionView : UIView
@property(weak,nonatomic)id<IntroductionDataSource> dataSource;
-(void) removeWithCompletion:(void(^)(void))block;
-(void)reload;
@end
