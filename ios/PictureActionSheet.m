//
//  PictureActionSheet.m
//  XYHealth
//
//  Created by 肖信波 on 14-8-1.
//  Copyright (c) 2014年 junxian. All rights reserved.
//

#import "PictureActionSheet.h"
#import "UIView+Ext.h"
@implementation PictureActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id<PictureActionSheetDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        self.title = title;
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:245 green:245 blue:245 alpha:1.0];
    }
    
    return self;
}

- (void)show
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];

    _backgroundView = [[UIView alloc] initWithFrame:view.bounds];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.0f;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_backgroundView addGestureRecognizer:tapGestureRecognizer];

    [view addSubview:_backgroundView];

    _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.bounds.size.width, 185.0f)];
    _sheetView.backgroundColor = [UIColor clearColor]; //RGBA_COLOR(249.0f, 249.0f, 249.0f, 1.0f);

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _sheetView.frame.size.width, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label=[self viewLabelWithFont:label text:self.title font:[UIFont systemFontOfSize:16] color:[UIColor grayColor]];
    [_sheetView addSubview:label];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    cancelButton.frame = CGRectMake(320 - 70, 0, 70, 44.0f);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [_sheetView addSubview:cancelButton];
    
    
    CGFloat offsetX = 50;

    UIButton *sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sinaButton.tag = 0;
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"picture_select_from_caram"] forState:UIControlStateNormal];
    [sinaButton addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
    sinaButton.frame = CGRectMake(offsetX , 55.0f, 80.0f, 80.0f);
    [_sheetView addSubview:sinaButton];

    UIButton *wxSessionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wxSessionButton.tag = 1;
    [wxSessionButton setBackgroundImage:[UIImage imageNamed:@"picture_select_from_lib"] forState:UIControlStateNormal];
    [wxSessionButton addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
    wxSessionButton.frame = CGRectMake(CGRectGetMaxX(sinaButton.frame) + 60, 55.0f, 80.0f, 80.0f);
    [_sheetView addSubview:wxSessionButton];

    CGFloat labelY = CGRectGetMaxY(sinaButton.frame) + 12.0f;
    CGFloat labelW = 80;

    UILabel *sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, labelY, labelW+60, 15.0f)];

    sinaLabel=[self viewLabelWithFont:sinaLabel text:@"拍照" font:[UIFont systemFontOfSize:14] color:[UIColor grayColor]];
    sinaLabel.textAlignment = NSTextAlignmentCenter;
    [_sheetView addSubview:sinaLabel];

    UILabel *wxSessionLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, labelY, labelW + 60, 15.0f)];

    wxSessionLabel=[self viewLabelWithFont:wxSessionLabel
                                        text:@"从图库里选择"
                                        font:[UIFont systemFontOfSize:14]
                                       color:[UIColor grayColor]];
    wxSessionLabel.textAlignment = NSTextAlignmentCenter;
    [_sheetView addSubview:wxSessionLabel];

    [self addSubview:_sheetView];
    [view addSubview:self];
    
    {
        // 重新设置按钮的位置(问文字没有居中) by fan
        sinaButton.centerX = sinaLabel.centerX;
        wxSessionButton.centerX = wxSessionLabel.centerX;
    }

    self.frame =  CGRectMake(0.0f, view.bounds.size.height, view.bounds.size.width, _sheetView.frame.size.height);

    [UIView beginAnimations:@"showShareSheet" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.4;
        self.frame = CGRectMake(0.0f, view.bounds.size.height - _sheetView.frame.size.height, view.bounds.size.width, _sheetView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    [UIView commitAnimations];
}

-(UILabel*)viewLabelWithFont:(UILabel *)label text:(NSString *)text font:(UIFont*)font color:(UIColor*)color
{
    if (text != nil) {
        label.text=text;
    }
    
    ////设置大字体
    //    if ( [[PublicMethod getSetInfo:Local_font_swit] integerValue]==0)
    //    {
    //        label.font=font;
    //
    //    } else{
    //
    //        float size=   [font pointSize];
    //        label.font=[UIFont systemFontOfSize:size*1.2];
    //
    //    }
    
    label.font=font;
    label.textColor=color;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(pictureActionSheetCancel:)]) {
        [self.delegate pictureActionSheetCancel:self];
    }
    
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(void (^)())completion
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.0;
        self.frame = CGRectMake(0.0f, view.bounds.size.height, view.bounds.size.width, 161.0f);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            if(completion) {
                completion();
            }
        }
    }];
    [UIView commitAnimations];
}

- (void)touchedButton:(UIButton *)button {
    [self dismissWithCompletion:^{
        if ([self.delegate respondsToSelector:@selector(pictureActionSheet:clickedButtonAtIndex:)]) {
            [self.delegate pictureActionSheet:self clickedButtonAtIndex:button.tag];
        }
    }];
}



@end
