#import "RCTBridgeModule.h"
#import <UIKit/UIKit.h>
#import "PictureActionSheet.h"

typedef NS_ENUM(NSInteger, RNImagePickerTarget) {
  RNImagePickerTargetCamera = 1,
  RNImagePickerTargetLibrarySingleImage,
};

@interface ImagePickerManager : NSObject <RCTBridgeModule, UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,PictureActionSheetDelegate>

@end
