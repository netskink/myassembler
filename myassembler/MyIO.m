//
//  io.m
//  myassembler
//
//  Created by John Fred Davis on 6/5/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyIO.h"
#import "utils.h"

@implementation MyIO

@synthesize niCurrentEntry;
@synthesize pnsFileName;
@synthesize someArray;


- (id)init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        niCurrentEntry = 0;
        
        
        someArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 1000; i++) {
                [someArray insertObject: @"" atIndex:i];
        }
        
    }
    return self;
}

// Adding a new line also increments the instruction address
-(BOOL)addBits:(NSString *)bits addNewline:(Boolean)bAddNewLine
{
    
    // Add bits to current entry.
    someArray[niCurrentEntry] = [NSString stringWithFormat:@"%@%@", someArray[niCurrentEntry], bits];
    
    // If addNewLine flag is true, append a new line to entry.
    if (bAddNewLine) {
        someArray[niCurrentEntry] = [NSString stringWithFormat:@"%@%@", someArray[niCurrentEntry], @"\n"];
        niCurrentEntry = niCurrentEntry+1;
    }
    
    return TRUE;
}

-(void)dump
{
    char *pchBuffer = NULL;
    
    for (int i = 0; i < niCurrentEntry; i++) {
        pchBuffer = NStoChar([someArray objectAtIndex: i], pchBuffer);

        
        printf("%s",pchBuffer);
//        [someArray insertObject: @"" atIndex:i];
    }
    
}

@end
