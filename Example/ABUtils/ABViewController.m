//
//  ABViewController.m
//  ABUtils
//
//  Created by Andrew Boryk on 01/06/2017.
//  Copyright (c) 2017 Andrew Boryk. All rights reserved.
//

#import "ABViewController.h"

@interface ABViewController ()

@end

@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //////// DEV ORIENTED FUNCTIONS ////////
    
    // Print can be used in replacement for NSLog. Print to console is done through CFShow. Also, print to console will not be done on production, only will print when app is in Debug mode.
    // Print has two methods
    // 1. PrintString: Accepts a string and prints it to console
    // 2. Print Tag: Accepts an object to be printed to console, as well as a tag string to preceed it
    
    [ABUtils printString:@"Hello World! \n"];
    [ABUtils print:@"\"Hello World!\"" tag:@"Narrator"];
    
    [ABUtils printString:@"\n\n"];
    
    //////// CONDITIONAL ORIENTED FUNCTIONS ////////
    
    // the 'notNull' function is helpful in determining whether an object is valid, that is, the value is not null or nil. In Swift, you can determine if a variable is nil using '!'. This is not available in Objective-C, so this function can be used in its place. It has a sister-function, 'isNull', if you are looking to determine that a variable is null or nil.
    NSNull *null = [NSNull new];
    if ([ABUtils notNull:null]) {
        [ABUtils print:@"False" tag:@"isNull"];
    }
    else if ([ABUtils isNull:null]) {
        [ABUtils print:@"True" tag:@"isNull"];
    }
    
    // Similar to the 'notNull' function, the 'notNil' is useful in determining whether an object is nil. In Swift, you can determine if a variable is nil using '!'. This is not available in Objective-C, so this function can be used in its place. It has a sister-function, 'isNil', if you are looking to determine that a variable is nil.
    NSString *testString = nil;
    
    if ([ABUtils notNil:testString]) {
        [ABUtils print:@"False" tag:@"isNil"];
    }
    else {
        [ABUtils print:@"True" tag:@"isNil"];
    }
    
    [ABUtils printString:@"\n\n"];
    
    // The 'notBlank' function is useful in determining whether a string is blank. This function can be used as a conditional in determining if a user has filled out a textfield.
    testString = @"\n\nF$%OO B  4AR \n";
    
    [ABUtils print:testString tag:@"Original String"];
    
    if ([ABUtils notBlank: testString]) {
        [ABUtils print:@"False" tag:@"notBlank"];
    }
    else {
        [ABUtils print:@"True" tag:@"notBlank"];
    }
    
    // There are several functions to modifying and cleaning strings:
    // 1. removeSpecialCharacters: Removes characters from the string that are not an upper or lowercase letter
    // 2. trimWhiteSpace: Trims white space from the ends of a string, such as ' ' and '\n'
    // 3. trimMultiSpace: Trims multispace from a string, and turns '\n\n' into '\n' as well as '  ' into ' '
    // 4. trimWhiteAndMultiSpace: An option which combines the previous two functions
    // 5. removeSpaces: Removes all spaces and new lines from a string
    
    [ABUtils print:[ABUtils removeSpecialCharacters:testString] tag:@"removeSpecialCharacters"];
    [ABUtils print:[ABUtils trimWhiteSpace:testString] tag:@"trimWhiteSpace"];
    [ABUtils print:[ABUtils trimMultiSpace:testString] tag:@"trimMultiSpace"];
    [ABUtils print:[ABUtils trimWhiteAndMultiSpace:testString] tag:@"trimWhiteAndMultiSpace"];
    [ABUtils print:[ABUtils removeSpaces:testString] tag:@"removeSpaces"];
    
    [ABUtils printString:@"\n\n"];
    
    // To determine if an email is a valid format, you can use the 'isValidEmail' function.
    
    testString = @"john.smith@gmailcom";
    
    if ([ABUtils isValidEmail: testString]) {
        [ABUtils print:@"Valid" tag:testString];
    }
    else {
        [ABUtils print:@"Invalid" tag:testString];
    }
    
    testString = @"john.smith@gmail.com";
    
    if ([ABUtils isValidEmail: testString]) {
        [ABUtils print:@"Valid" tag:testString];
    }
    else {
        [ABUtils print:@"Invalid" tag:testString];
    }
    
    // The last of the conditional functions is 'boolValue'. This function is used to parse the bool value out of an NSString or NSNumber.
    
    testString = @"1";
    
    if ([ABUtils boolValue: testString]) {
        [ABUtils print:@"True" tag:testString];
    }
    else {
        [ABUtils print:@"False" tag:testString];
    }
    
    [ABUtils printString:@"\n\n"];
    
    //////// TIME ORIENTED FUNCTIONS ////////
    
    // The 'timeZone' quickly returns the time zone of the user
    
    [ABUtils print:[ABUtils timeZone] tag:@"Time Zone"];
    
    // The 'ordinalSuffixFromInt' function returns the proper ordinal suffix for an int (ie. st, rd, nd)
    // The 'orinalNumber' function simplifies the previous function, by supplying the ordinal suffix, and appending it to the number, returning a full string
    [ABUtils printString:[NSString stringWithFormat:@"1%@ Place", [ABUtils ordinalSuffixFromInt: 1]]];
    [ABUtils printString:[NSString stringWithFormat:@"%@ Place", [ABUtils ordinalNumber: 2]]];
    
    [ABUtils printString:@"\n\n"];
    
    // The 'endOfDay' function returns an NSDate which represents 11:59 PM on the provided date
    // The 'endOfTomorrow' function is similar to the previous function, but provides the end of the date for tomorrow
    
    [ABUtils print:[ABUtils endOfDay:[NSDate date]] tag:@"End of Today"];
    [ABUtils print:[ABUtils endOfTomorrow] tag:@"End of Tomorrow"];
    
    // The 'differenceMet' function is used to determine if a number of specified days have passed between now and the date provided.
    
    NSDate *tomorrowDate = [ABUtils endOfTomorrow];
    
    if ([ABUtils differenceMet:tomorrowDate days:5]) {
        [ABUtils printString:@"There is a 5 day difference."];
    }
    else {
        [ABUtils printString:@"There isn't a 5 day difference."];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
