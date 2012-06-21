//
//  PhotoButton.m
//
//  Created by AT on 6/18/12.
//

#import "PhotoButton.h"
#import "PBImageHelper.h"

@implementation PhotoButton

@synthesize viewController;
@synthesize popoverController;
@synthesize photoSize;
@synthesize photoName;

- (void)initCommon
{
    // Create a default image for button
    [self addTarget: self action: @selector(button_clicked:) forControlEvents: UIControlEventTouchUpInside];
    
    UIImage *image = [PBImageHelper loadImageFromDocuments: photoName];
    if (!image) {
        image = [UIImage imageNamed:@"add_photo.png"];
    }
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder])){
        [self initCommon];
	}
	return self;
}

- (void)button_clicked: (id)sender
{
	self.selected = !self.selected;
    
    // cancel button will not show up on iPad
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Choose"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Delete Photo"
                                  otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView: self.viewController.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissModalViewControllerAnimated:YES];
    
    UIImage *image = nil;
    
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (image) {
        UIGraphicsBeginImageContext(photoSize);
        [image drawInRect:CGRectMake(0, 0, photoSize.width, photoSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [PBImageHelper saveImageToDocuments:image withName:photoName];
    }
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) takeOrChoosePhoto:(BOOL) take
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    
    if (take) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Oh Snap" delegate:nil cancelButtonTitle:@"Failed to load the camera." otherButtonTitles:nil];
            [alert show];
        }
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; 
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.viewController presentModalViewController:picker animated:YES];
    }else {
        popoverController=[[UIPopoverController alloc] initWithContentViewController:picker];
        //popoverController.delegate=self;
        [popoverController presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (void) deletePhoto
{
    [PBImageHelper deleteFileFromDocuments: photoName];
    UIImage *image = [UIImage imageNamed:@"add_photo.png"];
    [self setBackgroundImage:image forState:UIControlStateNormal]; 
}

#pragma mark - UIActionSheetDelegate protocol

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {        // delete photo
        [self deletePhoto];
    } else if (buttonIndex == 1) { // take photo
        [self takeOrChoosePhoto:TRUE];
    } else if (buttonIndex == 2) { // choose photo
        [self takeOrChoosePhoto: FALSE];
    } else {                       // cancel
        // NOP
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
