//
//  ABUtils.m
//  Pods
//
//  Created by Andrew Boryk on 1/6/17.
//
//

#import "ABUtils.h"

@implementation ABUtils

@synthesize serverDateFormatter;
@synthesize decimalFormatter;

+ (id)sharedInstance {
    static ABUtils *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
        
    });
    return sharedMyInstance;
}

- (id)init {
    if (self = [super init]) {
        // Initialize NSDateFormatter
        
        serverDateFormatter = [[NSDateFormatter alloc] init];
        [serverDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        [serverDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
    }
    return self;
}

+ (void) print: (id) dictionary tag: (NSString *) tag {
    
    
#ifdef DEBUG
    if ([ABUtils notNull:tag]) {
        CFShow((__bridge CFTypeRef)[NSString stringWithFormat:@"%@: %@", tag, dictionary]);
    }
    else {
        CFShow((__bridge CFTypeRef)(dictionary));
    }
#endif
}

+ (void) printString: (NSString *) string {
    
#ifdef DEBUG
    CFShow((__bridge CFTypeRef)(string));
#endif
}

#pragma mark - Conditional Oriented
+ (BOOL)notNull:(id)object {
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] || object == nil) {
        return false;
    }
    else {
        return true;
    }
}

+ (BOOL)isNull:(id)object {
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] || object == nil) {
        return true;
    }
    else {
        return false;
    }
}

+ (BOOL)notNil:(id)object {
    if (object == nil) {
        return false;
    }
    else {
        return true;
    }
}

+ (BOOL)isNil:(id)object {
    if (object == nil) {
        return true;
    }
    else {
        return false;
    }
}

+ (BOOL)notBlank: (NSString *) text {
    if ([ABUtils notNull:text]) {
        if (![text isEqualToString:@""]) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isValidEmail: (NSString *)string
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

+ (BOOL) boolValue: (id) value {
    if ([ABUtils notNull:value]) {
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            return [value boolValue];
        }
    }
    
    return NO;
}

#pragma mark - String Modification Oriented

+ (NSString *)removeSpecialCharacters: (NSString *) text {
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    return  [[text componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
}

+ (NSString *)trimWhiteSpace: (NSString *) text {
    if ([ABUtils notNull:text]) {
        text = [text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    return text;
}

+ (NSString *)trimMultiSpace: (NSString *) text {
    if ([ABUtils notNull:text]) {
        while ([text containsString:@"  "]) {
            text = [text stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        }
        
        while ([text containsString:@"\n\n"]) {
            text = [text stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
        }
    }
    
    return text;
}

+ (NSString *)trimWhiteAndMultiSpace: (NSString *) text {
    if ([ABUtils notNull:text]) {
        text = [ABUtils trimWhiteSpace:text];
        text = [ABUtils trimMultiSpace:text];
    }
    
    return text;
}

+ (NSString *)removeSpaces: (NSString *) text {
    text = [self trimWhiteAndMultiSpace:text];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return text;
}

#pragma mark - Time Oriented

+ (NSString *)timeZone {
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    return tzName;
}

+ (NSString *)ordinalSuffixFromInt:(NSInteger)number {
    NSArray *cSfx = [NSArray arrayWithObjects:@"th", @"st", @"nd", @"rd", @"th", @"th", @"th", @"th", @"th", @"th", nil];
    NSString *suffix = @"th";
    
    number = labs(number % 100);
    if ((number < 10) || (number > 19)) {
        suffix = [cSfx objectAtIndex:number % 10];
    }
    return suffix;
}

+ (NSString *)ordinalNumberString:(NSInteger)number {
    NSString *suffix = [ABUtils ordinalSuffixFromInt:number];
    int numberInt = (int)number;
    return [NSString stringWithFormat:@"%i%@", numberInt, suffix];
}

+ (NSDate *)endOfDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    cal.timeZone = [NSTimeZone localTimeZone];
    
    NSDateComponents *components = [cal components:(  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:date];
    
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [cal dateFromComponents:components];
    
}


+ (NSDate *)endOfTomorrow
{
    NSDate *now = [NSDate date];
    int daysToAdd = 1;
    NSDate *tomorrowDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    return [ABUtils endOfDay:tomorrowDate];
}

+ (BOOL)differenceMet: (NSDate *) time days: (int) days {
    
    if (![ABUtils notNull:time] || days <= 0) {
        return YES;
    }
    
    NSString *dateString = [[[ABUtils sharedInstance] serverDateFormatter] stringFromDate:time];
    NSDate *dateFromString = [[[ABUtils sharedInstance] serverDateFormatter] dateFromString:dateString];
    
    NSDate *nowDate = [NSDate date];
    NSString *nowDateString = [[[ABUtils sharedInstance] serverDateFormatter] stringFromDate:nowDate];
    nowDate = [[[ABUtils sharedInstance] serverDateFormatter] dateFromString:nowDateString];
    
    //Post has happened
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:dateFromString
                                                 toDate:nowDate
                                                options:0];
    
    if (components.day >= days) {
        return YES;
    }
    
    return NO;
    
}

#pragma mark - Number Oriented

- (NSString *) decimalNumber: (NSNumber *)value {
    NSString *formattedOutput = [decimalFormatter stringFromNumber:value];
    return formattedOutput;
}

+ (NSString *) commaFormat: (int)value {
    return [[ABUtils sharedInstance] decimalNumber:[NSNumber numberWithInt:value]];
}

+ (NSString *) commaFormatNumber: (NSNumber *)value {
    if ([ABUtils notNull:value]) {
        if ((value.intValue/1000) > 0) {
            if ((value.intValue/100000) > 0) {
                if ((value.intValue/1000000) > 0) {
                    if ((value.intValue/100000000) > 0) {
                        if ((value.intValue/1000000000) > 0) {
                            if ((value.intValue/100000000000) > 0) {
                                if ((value.intValue/1000000000000) > 0) {
                                    double floatNumber = (value.doubleValue/1000000000000);
                                    return [NSString stringWithFormat:@"%0.1fT", floatNumber];
                                }
                                else {
                                    NSInteger intNumber = (value.integerValue/1000000000);
                                    return [NSString stringWithFormat:@"%liB", (long)intNumber];
                                }
                            }
                            else {
                                double floatNumber = (value.doubleValue/1000000000);
                                return [NSString stringWithFormat:@"%0.1fB", floatNumber];
                            }
                            
                        }
                        else {
                            NSInteger intNumber = (value.integerValue/1000000);
                            return [NSString stringWithFormat:@"%liM", (long)intNumber];
                        }
                        
                    }
                    else {
                        float floatNumber = (value.doubleValue/1000000);
                        return [NSString stringWithFormat:@"%0.1fM", floatNumber];
                    }
                }
                else {
                    NSInteger intNumber = (value.integerValue/1000);
                    return [NSString stringWithFormat:@"%liK", (long)intNumber];
                }
            }
            else {
                float floatNumber = (value.doubleValue/1000);
                return [NSString stringWithFormat:@"%0.1fK", floatNumber];
            }
            
        }
        else {
            return [[ABUtils sharedInstance] decimalNumber:value];
        }
        
    }
    return @"0";
}

#pragma mark - UI Oriented

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *) platformType
{
    
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch";
    
    //    // Simulator
    //    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    //    {
    //        BOOL smallerScreen = ([[UIScreen mainScreen] bounds].size.width < 768.0);
    //        return (smallerScreen ? @"iPhone Simulator" : @"iPad Simulator");
    //    }
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
    
}

+ (NSString *) modelTypeString {
    
    NSString *platform = [ABUtils platformType];
    
    /// This function is only useful for iPhone Only apps, the iPad screen sizes will register as iPhone 4 size because they are 3:4 resolution.
    if ([platform isEqualToString:@"iPhone 1G"] || [platform isEqualToString:@"iPhone 3G"] || [platform isEqualToString:@"iPhone 3GS"] || [platform isEqualToString:@"iPhone 4"] || [platform isEqualToString:@"iPhone 4S"] || [platform isEqualToString:@"iPod Touch 1G"] || [platform isEqualToString:@"iPod Touch 2G"] || [platform isEqualToString:@"iPod Touch 3G"] || [platform isEqualToString:@"iPod Touch 4G"] || [platform containsString:@"iPad"] || [platform isEqualToString:@"iPad Simulator"]) {
        return @"iPhone 3.5 inch";
    }
    else if ([platform containsString:@"iPhone 5"] || [platform isEqualToString:@"iPod Touch 5G"] || [platform isEqualToString:@"iPod Touch 6G"] || [platform isEqualToString:@"iPhone Simulator"]) {
        return @"iPhone 4.0 inch";
    }
    else if ([platform isEqualToString:@"iPhone 6"] || [platform isEqualToString:@"iPhone 6S"] || [platform isEqualToString:@"iPhone 7"]) {
        return @"iPhone 6 size";
    }
    else if ([platform isEqualToString:@"iPhone 6 Plus"] || [platform isEqualToString:@"iPhone 6S Plus"] || [platform isEqualToString:@"iPhone 7 Plus"]) {
        return @"iPhone Plus size";
    }
    else {
        return @"Simulator";
    }
}

+ (ModelSizeType) modelTypeSize {
    
    NSString *platform = [ABUtils platformType];
    
    /// This function is only useful for iPhone Only apps, the iPad screen sizes will register as iPhone 4 size because they are 3:4 resolution.
    if ([platform isEqualToString:@"iPhone 1G"] || [platform isEqualToString:@"iPhone 3G"] || [platform isEqualToString:@"iPhone 3GS"] || [platform isEqualToString:@"iPhone 4"] || [platform isEqualToString:@"iPhone 4S"] || [platform isEqualToString:@"iPod Touch 1G"] || [platform isEqualToString:@"iPod Touch 2G"] || [platform isEqualToString:@"iPod Touch 3G"] || [platform isEqualToString:@"iPod Touch 4G"] || [platform containsString:@"iPad"] || [platform isEqualToString:@"iPad Simulator"]) {
        return iPhone4Size;
    }
    else if ([platform containsString:@"iPhone 5"] || [platform isEqualToString:@"iPod Touch 5G"] || [platform isEqualToString:@"iPod Touch 6G"] || [platform isEqualToString:@"iPhone Simulator"]) {
        return iPhone5Size;
    }
    else if ([platform isEqualToString:@"iPhone 6"] || [platform isEqualToString:@"iPhone 6S"] || [platform isEqualToString:@"iPhone 7"]) {
        return iPhone6Size;
    }
    else if ([platform isEqualToString:@"iPhone 6 Plus"] || [platform isEqualToString:@"iPhone 6S Plus"] || [platform isEqualToString:@"iPhone 7 Plus"]) {
        return iPhone6PlusSize;
    }
    else {
        return Simulator;
    }
}

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[self removeSpaces:hex] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma mark - Image/Video Oriented

+ (UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 1080.0f; // Set to whatever resolution desired
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = ceil(CGImageGetWidth(imgRef));
    CGFloat height = ceil(CGImageGetHeight(imgRef));
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, ceil(width), ceil(height));
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = ceil(width)/ceil(height);
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = ceil(bounds.size.width) / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = ceil(bounds.size.height) * ratio;
        }
    }
    
    //    CGFloat scaleRatio = bounds.size.width / width;
    CGFloat scaleRatio = ceil(bounds.size.width)  / ceil(width);
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(ceil(imageSize.width), 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(ceil(imageSize.width), ceil(imageSize.height));
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = ceil(bounds.size.height);
            bounds.size.height = ceil(bounds.size.width);
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = ceil(bounds.size.height);
            bounds.size.height = ceil(bounds.size.width);
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, ceil(imageSize.width));
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = ceil(bounds.size.height);
            bounds.size.height = ceil(bounds.size.width);
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = ceil(bounds.size.height);
            bounds.size.height = ceil(bounds.size.width);
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(ceil(imageSize.height), 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
    //return imageCopy;
}

+ (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image, 0.6f) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


+ (NSString *)encodeVideoToBase64String:(NSURL *)videoURL {
    return [[NSData dataWithContentsOfURL:videoURL] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *) generateBlackAndWhiteImage: (UIImage *) image {
    
    if ([ABUtils notNull:image]) {
        CIImage *BWbeginImage = [[CIImage alloc]initWithImage: image];
        
        CIFilter *bwFilter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey, BWbeginImage, @"inputIntensity", [NSNumber numberWithFloat:1.0], @"inputColor", [[CIColor alloc] initWithColor:[UIColor whiteColor]], nil];
        
        CIImage *output = bwFilter.outputImage;
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
        UIImage *bwImage = [UIImage imageWithCGImage:cgiimage];
        
        if ([ABUtils notNull:bwImage]) {
            return bwImage;
        }
    }
    
    return nil;
}

+ (UIImage *) generateSepiaImage: (UIImage *) image {
    
    if ([ABUtils notNull:image]) {
        // Sepia Image
        CIImage *beginImage =[[CIImage alloc]initWithImage:image];
        
        CIContext *sepiaContext=[CIContext contextWithOptions:nil];
        
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                      keysAndValues: kCIInputImageKey, beginImage, @"inputIntensity", @0.6, nil];
        
        CIImage *outImage = [filter outputImage];
        CGImageRef cgimg= [sepiaContext createCGImage:outImage fromRect:[outImage extent]];
        UIImage *sepiaImage = [UIImage imageWithCGImage:cgimg];
        
        if ([ABUtils notNull:sepiaImage]) {
            return sepiaImage;
        }
    }
    
    return nil;
}

+ (UIImage *) generateSaturatedImage: (UIImage *) image {
    
    if ([ABUtils notNull:image]) {
        // Saturated image
        CIContext *saturationContext = [CIContext contextWithOptions:nil];
        CIImage *ciimage = [[CIImage alloc]initWithImage:image];
        
        CIFilter *satfilter = [CIFilter filterWithName:@"CIColorControls"];
        [satfilter setValue:ciimage forKey:kCIInputImageKey];
        [satfilter setValue:@2.0f forKey:kCIInputSaturationKey];
        
        CIImage *result = [satfilter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [saturationContext createCGImage:result fromRect:[result extent]];
        UIImage *saturatedImage = [UIImage imageWithCGImage:cgImage];
        
        if ([ABUtils notNull:saturatedImage]) {
            return saturatedImage;
        }
    }
    
    return nil;
}

+ (CGAffineTransform) reorient: (OrientationType)orientation size: (CGSize)size {
    switch (orientation) {
        case TurnNormal:
            //# 1 = 0th row is at the top, and 0th column is on the left.
            //# Orientation Normal
            //image.fOrientation = CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0.0, 0.0);
            
            return CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0.0, 0.0);
            break;
        case FlipHorizontal:
            //# 2 = 0th row is at the top, and 0th column is on the right.
            //# Flip Horizontal
            //image.fOrientation = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, w, 0.0)
            
            return CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, size.width, 0.0);
            break;
        case Rotate180:
            //# 3 = 0th row is at the bottom, and 0th column is on the right.
            //# Rotate 180 degrees
            //image.fOrientation = CGAffineTransformMake(-1.0, 0.0, 0.0, -1.0, w, h)
            
            return CGAffineTransformMake(-1.0, 0.0, 0.0, -1.0, size.width, size.height);
            break;
        case FlipVertical:
            //# 4 = 0th row is at the bottom, and 0th column is on the left.
            //# Flip Vertical
            //image.fOrientation = CGAffineTransformMake(1.0, 0.0, 0, -1.0, 0.0, h)
            
            return CGAffineTransformMake(1.0, 0.0, 0, -1.0, 0.0, size.height);
            break;
        case Rotate270FlipVertical:
            //# 5 = 0th row is on the left, and 0th column is the top.
            //# Rotate -90 degrees and Flip Vertical
            //image.fOrientation = CGAffineTransformMake(0.0, -1.0, -1.0, 0.0, h, w)
            
            return CGAffineTransformMake(0.0, -1.0, -1.0, 0.0, size.height, size.width);
            break;
        case Rotate90:
            //# 6 = 0th row is on the right, and 0th column is the top.
            //# Rotate 90 degrees
            //image.fOrientation = CGAffineTransformMake(0.0, -1.0, 1.0, 0.0, 0.0, w)
            
            return CGAffineTransformMake(0.0, -1.0, 1.0, 0.0, 0.0, size.width);
            break;
        case Rotate90FlipVertical:
            //# 7 = 0th row is on the right, and 0th column is the bottom.
            //# Rotate 90 degrees and Flip Vertical
            //image.fOrientation = CGAffineTransformMake(0.0, 1.0, 1.0, 0.0, 0.0, 0.0)
            
            return CGAffineTransformMake(0.0, 1.0, 1.0, 0.0, 0.0, 0.0);
            break;
        case Rotate270:
            //# 8 = 0th row is on the left, and 0th column is the bottom.
            //# Rotate -90 degrees
            //image.fOrientation = CGAffineTransformMake(0.0, 1.0,-1.0, 0.0, h, 0.0)
            
            return CGAffineTransformMake(0.0, 1.0,-1.0, 0.0, size.height, 0.0);
            break;
        default:
            return CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0.0, 0.0);
            break;
    }
}


@end
