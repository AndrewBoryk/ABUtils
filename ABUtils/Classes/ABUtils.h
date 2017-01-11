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

// Nice shortcuts for determining iOS version
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_OS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

// Type of rotation that should be applied to an AVAsset to return it to the proper orientation
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

// Model size for device
typedef NS_ENUM(NSInteger, ModelSizeType) {
    Simulator,
    iPhone4Size,
    iPhone5Size,
    iPhone6Size,
    iPhone6PlusSize,
};

@interface ABUtils : NSObject {
    
    /// Formatting dates from the server
    NSDateFormatter *serverDateFormatter;
    
    /// Formats numbers to include commas
    NSNumberFormatter *decimalFormatter;
}

/// Shared Instance of Utils
+ (id)sharedInstance;

/// Formatting dates from the server, in full format
@property (strong, nonatomic) NSDateFormatter *serverDateFormatter;

/// Formats numbers to include commas
@property (strong, nonatomic) NSNumberFormatter *decimalFormatter;

#pragma mark - Dev Oriented

/// Print dictionary with a tag, using CFShow
+ (void) print: (id) object tag: (NSString *) tag;

/// Print a string, using CFShow
+ (void) printString: (NSString *) string;

#pragma mark - Conditional Oriented

/// Returns true if the object is not null or nil, otherwise returns false
+ (BOOL)notNull:(id)object;

/// Returns true if the object is null or nil, otherwise returns false

+ (BOOL)isNull:(id)object;

/// Returns true if the object is not nil, returns true if the object is null
+ (BOOL)notNil:(id)object;

/// Returns true if the object is nil, returns false if the object is null
+ (BOOL)isNil:(id)object;

/// Returns true if the object is not just spaces or blank, otherwise returns false
+ (BOOL)notBlank: (NSString *) text;

/*!
 * @brief Determines if email is valid format
 * @param string email that is passed in
 * @return true if email is valid format, false otherwise
 */
+ (BOOL)isValidEmail: (NSString *)string;

/// Determines bool value for a NSString or NSNumber
+ (BOOL) boolValue: (id) value;

#pragma mark - String Modification Oriented

/*!
 * @brief Removes special characters from a string (%,#,&, etc.)
 * @param text the string looking to be converted
 * @return a string without special characters
 */
+ (NSString *)removeSpecialCharacters: (NSString *) text;

/// Trims white space and removes extra new lines from string
+ (NSString *)trimWhiteSpace: (NSString *) text;

/// Replaces instances of "\n\n" with "\n" and "  " with " "
+ (NSString *)trimMultiSpace: (NSString *) text;

/// Trims white space and removes extra new lines from string, and replaces instances of "\n\n" with "\n" and "  " with " "
+ (NSString *)trimWhiteAndMultiSpace: (NSString *) text;

/*!
 * @brief Removes spaces from a string
 * @param text The string that spaces will be removed from
 * @return A string without spaces
 */
+ (NSString *)removeSpaces: (NSString *) text;

#pragma mark - Time Oriented

/*!
 * @brief Determines the timezone of the user, and returns a string value of that time zone
 * @return timezone of the user in string format
 */
+ (NSString *)timeZone;

/// Returns the ordinal suffix for a number (ie. th, st, nd)
+ (NSString *)ordinalSuffixFromInt:(NSInteger)number;

/// Returns the number in string format with its proper ordinal suffix (ie. 5th, 1st, 2nd)
+ (NSString *)ordinalNumberString:(NSInteger)number;

/// Returns the NSDate for the end of date received
+ (NSDate *)endOfDay:(NSDate *)date;

/// Returns the NSDate for the end of tomorrow
+ (NSDate *)endOfTomorrow;

/**
 Determines if the time difference between now and the date received is more or equal to the number of days received

 @param time The time being compared to now
 @param days Number of days difference looking to be compare to date provided
 @return Returns true if the difference between now and the time provided is more than or equal to the number of days provided, otherwise returns false
 */
+ (BOOL)differenceMet: (NSDate *) time days: (int) days;

#pragma mark - Number Oriented

/// Returns decimal string for the number, with commas
- (NSString *) decimalNumber: (NSNumber *)value;

/// Returns int in comma format
+ (NSString *) commaFormat: (int)value;

/// Accepts number and returns it in comma format
+ (NSString *) commaFormatNumber: (NSNumber *)value;

#pragma mark - UI Oriented

/// Returns a UIColor for a hex string value
+ (UIColor *)colorWithHexString:(NSString*)hex;

/// Returns the platform type of the user's phone (ie. iPhone 5S)
+ (NSString *)platformType;

/// Returns the screen size of the device (iPhone only)
+ (NSString *)modelTypeString;

/// Determines model type for screen size
+ (ModelSizeType)modelTypeSize;

#pragma mark - Image/Video Oriented

/// Send image, and returns same image scaled to 1080px and rotated accordingly
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;

/// Generated a black and white image from the image received
+ (UIImage *) generateBlackAndWhiteImage: (UIImage *) image;

/// Generates an image with sepia tone from the image receieved
+ (UIImage *) generateSepiaImage: (UIImage *) image;

/// Generates a saturated image from the image received
+ (UIImage *) generateSaturatedImage: (UIImage *) image;

/// Encodes image to Base 64 for Backend
+ (NSString *)encodeToBase64String:(UIImage *)image;

/// Encodes video to Base 64 for Backend
+ (NSString *)encodeVideoToBase64String:(NSURL *)videoURL;

/// Provides the orientation transformation for reorienting videos
+ (CGAffineTransform) reorient: (OrientationType)orientation size: (CGSize)size;

@end

