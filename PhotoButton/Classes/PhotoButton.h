//
//  PhotoButton.h
//
//  Created by AT on 6/18/12.
//

#import <UIKit/UIKit.h>

@interface PhotoButton : UIButton
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
}

@property (nonatomic, strong) UIViewController    *viewController;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) NSString            *photoName;
@property (nonatomic)         CGSize              photoSize;

@end
