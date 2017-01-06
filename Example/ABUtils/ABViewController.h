//
//  ABViewController.h
//  ABUtils
//
//  Created by Andrew Boryk on 01/06/2017.
//  Copyright (c) 2017 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <ABUtils/ABUtils.h>
#import <QuartzCore/QuartzCore.h>

@interface ABViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/// Field where the user will enter in a hex string value, and will adjust the color preview
@property (strong, nonatomic) IBOutlet UITextField *hexField;

/// View which will preview the color based on the hex string entered into the field
@property (strong, nonatomic) IBOutlet UIView *colorPreview;

/// Button for adding a photo to edit
@property (strong, nonatomic) IBOutlet UIButton *addPhotoButton;

/// ImageView which displays photo being editted
@property (strong, nonatomic) IBOutlet UIImageView *photoView;

/// Button for turning the photo into black and white
@property (strong, nonatomic) IBOutlet UIButton *blackAndWhiteButton;

/// Button for changing the photo to sepia tone
@property (strong, nonatomic) IBOutlet UIButton *sepiaButton;

/// Button for changing the photo to saturated tone
@property (strong, nonatomic) IBOutlet UIButton *saturatedButton;

/// Add a photo to the photoView so that it can be editted
- (IBAction)addPhotoAction:(id)sender;

/// Changes the photo in the photoView into black and white
- (IBAction)blackAndWhiteAction:(id)sender;

/// Changes the photo in the photoView into sepia tone
- (IBAction)sepiaAction:(id)sender;

/// Changes the photo in the photoView into saturated tone
- (IBAction)saturatedAction:(id)sender;



@end
