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
    
    
    // Print can be used in replacement for NSLog. Print to console is done through CFShow. Also, print to console will not be done on production, only will print when app is in Debug mode.
    // Print has two methods
    // 1. PrintString: Accepts a string and prints it to console
    // 2. Print Tag: Accepts an object to be printed to console, as well as a tag string to preceed it
    
    [ABUtils printString:@"Hello World! \n"];
    [ABUtils print:@"\"Hello World!\"" tag:@"Narrator"];
    
    [ABUtils printString:@"\n\n"];
    
    // the 'notNull' function is helpful in determining whether an object is valid, that is, the value is not null or nil. In Swift, you can determine if a variable is nil using '!'. This is not available in Objective-C, so this function can be used in its place. It has a sister-function, 'isNull', if you are looking to determine that a variable is null or nil.
    NSNull *null = [NSNull new];
    if ([ABUtils notNull:null]) {
        [ABUtils print:@"False" tag:@"Result if null"];
    }
    else if ([ABUtils isNull:null]) {
        [ABUtils print:@"True" tag:@"Result if null"];
    }
    
    [ABUtils printString:@"\n\n"];
    
    // Similar to the 'notNull' function, the 'notNil' is useful in determining whether an object is nil. In Swift, you can determine if a variable is nil using '!'. This is not available in Objective-C, so this function can be used in its place. It has a sister-function, 'isNil', if you are looking to determine that a variable is nil.
    NSString *testString = nil;
    
    if ([ABUtils notNil:testString]) {
        [ABUtils print:@"False" tag:@"Result if nil"];
    }
    else {
        [ABUtils print:@"True" tag:@"Result if nil"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
