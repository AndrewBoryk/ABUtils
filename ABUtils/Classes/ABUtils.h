//
//  ABUtils.h
//  Pods
//
//  Created by Andrew Boryk on 1/6/17.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <stdlib.h>
#import <sys/sysctl.h>

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

/// Determines what type of rotation should be applied to an AVAsset to return it to the proper orientation
typedef NS_ENUM(NSInteger, OrientationType) {
    TurnNormal,
    FlipHorizontal,
    Rotate180,
    FlipVertical,
    Rotate270FlipVertical,
    Rotate90,
    Rotate90FlipVertical,
    Rotate270,
};

@interface ABUtils : NSObject {
    
    /// Formatting dates from the server
    NSDateFormatter *serverDateFormatter;
    
    /// Formats numbers to include commas
    NSNumberFormatter *decimalFormatter;
}

/// Shared Instance of Utils
+ (id)sharedInstance;

/// Formatting dates from the server
@property (strong, nonatomic) NSDateFormatter *serverDateFormatter;

/// Formats numbers to include commas
@property (strong, nonatomic) NSNumberFormatter *decimalFormatter;

#pragma mark - Dev Oriented

//void TNSLog(NSString *format, ...);

/// Print dictionary with a tag, using CFShow
+ (void) print: (id) dictionary tag: (NSString *) tag;

/// Print a string, using CFShow
+ (void) printString: (NSString *) string;

#pragma mark - Conditional Oriented

/*!
 * @brief Determines if an object is not null or nil
 * @param object the item looking to be analyzed
 * @return true if the object is not null or nil, false otherwise
 */
+ (BOOL)notNull:(id)object;

/// Returns true if the object is null or nil
+ (BOOL)isNull:(id)object;

/// Returns true if the object is not nil, returns true if the object is null
+ (BOOL)notNil:(id)object;

/// Returns true if the object is nil, returns false if the object is null
+ (BOOL)isNil:(id)object;

/*!
 * @brief Determines if a string is not blank
 * @param text the string looking to be analyzed
 * @return true if the object is not just spaces or blank, false if otherwise
 */
+ (BOOL)notBlank: (NSString *) text;

/*!
 * @brief Removes special characters from a string (%,#,&, etc.)
 * @param text the string looking to be converted
 * @return a string without special characters
 */
+ (NSString *)removeSpecialCharacters: (NSString *) text;

/// Trims white space and removes extra new lines from string
+ (NSString *)trimWhiteSpace: (NSString *) text;

/// Trims white space and removes extra new lines from string, with an option to trim multiple new lines or spaces
+ (NSString *)trimWhiteSpace: (NSString *) text andMultiSpace: (BOOL) trimMultiple;

/// Replaces instances of "\n\n" with "\n" and "  " with " "
+ (NSString *)trimMultiSpace: (NSString *) text;

/*!
 * @brief Removes spaces from a string
 * @param text the string that spaces will be removed from
 * @return a string without spaces
 */
+ (NSString *)removeSpaces: (NSString *) text;

/*!
 * @brief Determines if email is valid format
 * @param string email that is passed in
 * @return true if email is valid format, false otherwise
 */
+ (BOOL)isValidEmail: (NSString *)string;

/// Determines bool value for a NSString or NSNumber
+ (BOOL) boolValue: (id) value;

#pragma mark - Time Oriented

/*!
 * @brief Determines the timezone of the user
 * @return timezone of the user in string format
 */
+ (NSString *)timeZone;

/// Determines if the distance between now and the date received is more or equal to the number of days received
+ (BOOL)differenceMet: (NSDate *) time days: (int) days;

// Returns the NSDate for the end of date received
+ (NSDate *)endOfDay:(NSDate *)date;

// Returns the NSDate for the end of tomorrow
+ (NSDate *)endOfTomorrow;

/// Return decimal string for the number, with commas
- (NSString *) decimalNumber: (NSNumber *)value;

/// Returns int in comma format
+ (NSString *) commaFormat: (int)value;

/// Accepts number and returns it in comma format
+ (NSString *) commaFormatNumber: (NSNumber *)value;

#pragma mark - UI Oriented

// Returns a UIColor for a hex value
+ (UIColor *)colorWithHexString:(NSString*)hex;

// Returns the platform type of the user's phone
+ (NSString *)platformType;

/// Determines model type for screen
+ (NSString *) modelTypeScreen: (NSString *) platform;

#pragma mark - Image/Video Oriented

// Send image, and returns same image scalled and rotated
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;

// Encodes image to Base 64 for Backend
+ (NSString *)encodeToBase64String:(UIImage *)image;

// Encomes video to Base 64 for Backend
+ (NSString *)encodeVideoToBase64String:(NSURL *)videoURL;

/// Generated a black and white image from the image received
+ (UIImage *) generateBlackAndWhiteImage: (UIImage *) image;

/// Generates an image with sepia tone from the image receieved
+ (UIImage *) generateSepiaImage: (UIImage *) image;

/// Generates a saturated image from the image received
+ (UIImage *) generateSaturatedImage: (UIImage *) image;


#pragma mark - Orientations
// Provides the orientation transformation for reorienting videos
+ (CGAffineTransform) reorient: (OrientationType)orientation size: (CGSize)size;

@end

