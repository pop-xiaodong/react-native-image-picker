//
//  PictureActionSheet.h
//  XYHealth
//
//  Created by 肖信波 on 14-8-1.
//  Copyright (c) 2014年 junxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PictureActionSheet;

@protocol PictureActionSheetDelegate <NSObject>

- (void)pictureActionSheetCancel:(PictureActionSheet *)actionSheet;
- (void)pictureActionSheet:(PictureActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;


@end

@interface PictureActionSheet : UIView
{
    UIView *_backgroundView;
    UIView *_sheetView;
}

@property (nonatomic, assign) id<PictureActionSheetDelegate> delegate;
@property (nonatomic, retain) NSString *title;

- (id)initWithTitle:(NSString *)title delegate:(id<PictureActionSheetDelegate>)delegate;
- (void)show;

@end
