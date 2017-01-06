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

@interface ABViewController : UIViewController <UITextFieldDelegate>

/// Field where the user will enter in a hex string value, and will adjust the color preview
@property (strong, nonatomic) IBOutlet UITextField *hexField;

/// View which will preview the color based on the hex string entered into the field
@property (strong, nonatomic) IBOutlet UIView *colorPreview;

@end
