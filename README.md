<p align="center">
  <img src="https://github.com/AndrewBoryk/ABUtils/blob/master/ABUtilsLogo.png?raw=true" alt="ABUtils custom logo"/>
</p>

[![Version](https://img.shields.io/cocoapods/v/ABUtils.svg?style=flat)](http://cocoapods.org/pods/ABUtils)
[![License](https://img.shields.io/cocoapods/l/ABUtils.svg?style=flat)](http://cocoapods.org/pods/ABUtils)
[![Platform](https://img.shields.io/cocoapods/p/ABUtils.svg?style=flat)](http://cocoapods.org/pods/ABUtils)

## Description

ABUtils is a library which provides pre-written functionality. This makes it easier to develop cleaner code by removing the need for repetitive code, as well as easier to get started without having to re-write code between projects. As demand increases for a function, it will be added.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Requires iOS 8.0 or later
* Requires Automatic Reference Counting (ARC)

## Installation

ABUtils is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ABUtils"
```

## Usage

### Dev Functions

Print can be used in replacement for NSLog. Print to console is done through CFShow. Also, print to console will not be done on production, only will print when app is in Debug mode. Print has two methods:

1. _'print:tag':_ Accepts an object to be printed to console, as well as a tag string to preceed it
2. _'printString':_ Accepts a string and prints it to console
    
```objective-c
/// Print object to console using CFShow, includes a tag which will preceed the object in the print (ie. "Tag: Object") 
+ (void) print: (id) object tag: (NSString *) tag;

/// Print a string to console using CFShow
+ (void) printString: (NSString *) string;
```

The following macros can be used to easily determine the iOS version of the user's device:

```objective-c
/// Returns true if the device's iOS is version 5.0 or later
IS_OS_5_OR_LATER 

/// Returns true if the device's iOS is version 6.0 or later
IS_OS_6_OR_LATER

/// Returns true if the device's iOS is version 7.0 or later
IS_OS_7_OR_LATER

/// Returns true if the device's iOS is version 8.0 or later
IS_OS_8_OR_LATER

/// Returns true if the device's iOS is version 9.0 or later
IS_OS_9_OR_LATER

/// Returns true if the device's iOS is version 10.0 or later
IS_OS_10_OR_LATER
```

***
### Conditional Functions

The _'notNull'_ function is helpful in determining whether an object is valid, that is, the value is not null or nil. In Swift, you can determine if a variable is nil using '!'. This is not available in Objective-C, so this function can be used in its place. It has a sister-function, _'isNull'_, if you are looking to determine that a variable is null or nil.

```objective-c
/// Returns true if the object is not null or nil, otherwise returns false
+ (BOOL)notNull:(id)object;

/// Returns true if the object is null or nil, otherwise returns false
+ (BOOL)isNull:(id)object;
```

Similar to the _'notNull'_ function, the _'notNil'_ is useful in determining whether an object is nil. In Swift, you can determine if a variable is nil using '!'. This is not available in Objective-C, so this function can be used in its place. It has a sister-function, _'isNil'_, if you are looking to determine that a variable is nil.

```objective-c
/// Returns true if the object is not nil, returns true if the object is null
+ (BOOL)notNil:(id)object;

/// Returns true if the object is nil, returns false if the object is null
+ (BOOL)isNil:(id)object;
```

The _'notBlank'_ function is useful in determining whether a string is blank. This function can be used as a conditional in determining if a user has filled out a textfield.

```objective-c
/// Returns true if the object is not just spaces or blank, otherwise returns false
+ (BOOL)notBlank: (NSString *) text;
```

To determine if an email is a valid format, you can use the _'isValidEmail'_ function. This function uses a regex to ensure that the email is in the proper format and only contains only valid email address characters.

```objective-c
/// Determines if email is valid format
+ (BOOL)isValidEmail: (NSString *)string;
```

The last of the conditional functions is _'boolValue'_. This function is used to parse the bool value out of an NSString or NSNumber.

```objective-c
/// Determines bool value for a NSString or NSNumber
+ (BOOL) boolValue: (id) value;
```

***
### String Modification Functions

There are several functions to modifying and cleaning strings:

1. _'removeSpecialCharacters':_ Removes characters from the string that are not an upper or lowercase letter
2. _'trimWhiteSpace':_ Trims white space from the ends of a string, such as ' ' and '\n'
3. _'trimMultiSpace':_ Trims multispace from a string, and turns '\n\n' into '\n' as well as '  ' into ' '
4. _'trimWhiteAndMultiSpace':_ An option which combines the previous two functions
5. _'removeSpaces':_ Removes all spaces and new lines from a string
    
```objective-c

/// Removes characters from the string that are not an upper or lowercase letter
+ (NSString *)removeSpecialCharacters: (NSString *) text;

/// Trims white space from the ends of a string, such as ' ' and '\n'
+ (NSString *)trimWhiteSpace: (NSString *) text;

/// Trims multispace from a string, and turns '\n\n' into '\n' as well as '  ' into ' '
+ (NSString *)trimMultiSpace: (NSString *) text;

/// Trims white space and removes extra new lines from string, and replaces instances of "\n\n" with "\n" and "  " with " "
+ (NSString *)trimWhiteAndMultiSpace: (NSString *) text;

/// Removes all spaces and new lines from a string
+ (NSString *)removeSpaces: (NSString *) text;
```

***
### Time Functions

The _'timeZone'_ function quickly returns the time zone of the user in string format

```objective-c
/// Determines the timezone of the user, and returns a string value of that time zone
+ (NSString *)timeZone;
```

The _'ordinalSuffixFromInt'_ function returns the proper ordinal suffix for an int (ie. st, rd, nd). The _'ordinalNumberString'_ function simplifies the previous function, by supplying the ordinal suffix, and appending it to the number, returning a full string

```objective-c
/// Returns the ordinal suffix for a number (ie. th, st, nd)
+ (NSString *)ordinalSuffixFromInt:(NSInteger)number;

/// Returns the number in string format with its proper ordinal suffix (ie. 5th, 1st, 2nd)
+ (NSString *)ordinalNumberString:(NSInteger)number;
```

The _'endOfDay'_ function returns an NSDate which represents 11:59 PM on the provided date. The _'endOfTomorrow'_ function is similar to the previous function, but provides the end of the date for tomorrow.

```objective-c
// Returns the NSDate for the end of date received
+ (NSDate *)endOfDay:(NSDate *)date;

// Returns the NSDate for the end of tomorrow
+ (NSDate *)endOfTomorrow;
```

The _'differenceMet'_ function is used to determine if a number of specified days have passed between now and the date provided.

```objective-c
/// Determines if the time difference between now and the date received is more or equal to the number of days received
+ (BOOL)differenceMet: (NSDate *) time days: (int) days;
```

***
### Number Functions

The following functions return a string formatted from a number:

1. _'decimalNumber':_ Formats the number as a string with commas, accepting an NSNumber. This function should be called using a sharedInstance. Date and number formatters take up processing time, so this makes sure that the formatter used for this function is only initilized once.
2. _'commaFormat':_ Uses the previous function, but accepts an int.
3. _'commaFormatNumber':_ Formats the number to be a decimal with 1-3 number places, and shows K, M, B, or T (Thousand, Million, Billion, Trillion).

```objective-c
/// Returns decimal string for the number, with commas
- (NSString *) decimalNumber: (NSNumber *)value;

/// Returns int in comma format
+ (NSString *) commaFormat: (int)value;

/// Accepts number and returns it in comma format
+ (NSString *) commaFormatNumber: (NSNumber *)value;
```

***
### UI Functions

_'colorWithHexString'_ function is a very useful function. Currently, there is no easy way to use Hex strings to declare UIColors. This function accepts a 6-letter hex string (don't use the shortcut hex strings) and returns the UIColor for that string.

```objective-c
/// Returns a UIColor for a hex string value
+ (UIColor *)colorWithHexString:(NSString*)hex;
```

The following functions provide a 1 line means to determine the model of a device

1. _'platformType':_ Returns the device and model of the user's device (ie. iPhone 5S)
2. _'modelTypeString':_ There are currently 4 different resolution sizes. When developing apps and adjusting UI depending on the size of the devices screen, this function lets you know what the screen resolution is based off of specific models. The 5 types that can be returned: iPhone 3.5 inch, iPhone 4 inch, iPhone 6 size, iPhone Plus size, and Simulator. I chose names that I could understand consistently for reference.
3. _'modelTypeSize':_ This function is the same as the previous, however it returns a type using my custom enum. The different values are - iPhone4Size, iPhone5Size, iPhone6Size, iPhone6PlusSize, and Simulator.

```objective-c
/// Returns the platform type of the user's phone (ie. "iPhone 5S")
+ (NSString *)platformType;

/// Returns the screen size of the device (iPhone only) (ie. "iPhone Plus size")
+ (NSString *)modelTypeString;

/// Determines model type for screen size (ie. iPhone4Size)
+ (ModelSizeType)modelTypeSize;
```

***
### Image/Video Functions

The following functions provide tools in editing and encoding media:

1. _'scaleAndRotateImage':_ Scales the image to 1080px and rotates it to the orientation it was taken in
2. _'generateBlackAndWhiteImage':_ Generates a black and white version of the provided image
3. _'generateSepiaImage':_ Generates a sepia version of the provided image
4. _'generateSaturatedImage':_ Generates a saturated version of the provided image
5. _'encodeToBase64String':_ Encodes the image provided into a Base64 string
6. _'encodeVideoToBase64String':_ Encodes the video provided into a Base64 string

```objective-c
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
```

The function _'reorient'_ accepts an orientation change and a size, and returns the correct CGAffineTransform necessary to receive the result requested. This function proves very useful when working with AVAssetExporters and custom AVPlayers. Any person that has had to work with AVAssetExporter in order to crop videos will understand how useful this function can be in achieving the correct video orientation when the AVAsset is exported.

```objective-c
/// Provides the orientation transformation for reorienting videos
+ (CGAffineTransform) reorient: (OrientationType)orientation size: (CGSize)size;
```


## Author

Andrew Boryk, andrewcboryk@gmail.com

## License

ABUtils is available under the MIT license. See the LICENSE file for more info.
