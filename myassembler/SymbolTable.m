//
//  SymbolTable.m
//  myassembler
//
//  Created by John Fred Davis on 6/6/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SymbolTable.h"
#import "utils.h"

@implementation SymbolTable

// http://rypress.com/tutorials/objective-c/data-types/nsdictionary

- (id)init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        pSymbols = [NSMutableDictionary
                                     dictionaryWithDictionary:@{
                                                                @"SP"      : @"0000000000000000",
                                                                @"LCL"     : @"0000000000000001",
                                                                @"ARG"     : @"0000000000000010",
                                                                @"THIS"    : @"0000000000000011",
                                                                @"THAT"    : @"0000000000000100",
                                                                @"R0"      : @"0000000000000000",
                                                                @"R1"      : @"0000000000000001",
                                                                @"R2"      : @"0000000000000010",
                                                                @"R3"      : @"0000000000000011",
                                                                @"R4"      : @"0000000000000100",
                                                                @"R5"      : @"0000000000000101",
                                                                @"R6"      : @"0000000000000110",
                                                                @"R7"      : @"0000000000000111",
                                                                @"R8"      : @"0000000000001000",
                                                                @"R9"      : @"0000000000001001",
                                                                @"R10"     : @"0000000000001010",
                                                                @"R11"     : @"0000000000001011",
                                                                @"R12"     : @"0000000000001100",
                                                                @"R13"     : @"0000000000001101",
                                                                @"R14"     : @"0000000000001110",
                                                                @"R15"     : @"0000000000001111",
                                                                @"SCREEN"  : @"0100000000000000",
                                                                @"32"      : @"0000000000100000",
                                                                @"0"       : @"0000000000000000",
                                                                @"KBD"     : @"0000011000000000"
                                                                }];
        
        
    
        uiNextFree = 16;  // Always points to the next available symbol address.
        uiPC = 0; // Increment each time its not a A or C command.

        
    }
    return self;
}

@synthesize uiPC;



-(NSString *)getAddress:(NSString *) pnsStringIn result:(NSString *) pnsStringOut
{
    
    pnsStringOut = pSymbols[pnsStringIn];
    
    if (Nil == pnsStringOut) {
        
        pnsStringOut = CharToNS(bit_rep[uiNextFree], pnsStringOut);
        
        pSymbols[pnsStringIn] = pnsStringOut;
    }
    return pnsStringOut;
}

-(NSString *)getLabelAddress:(NSString *) pnsStringIn result:(NSString *) pnsStringOut
{
    
//    pnsStringOut = pSymbols[pnsStringIn];
    
//    if (Nil == pnsStringOut) {
        
        pnsStringOut = CharToNS(bit_rep[uiPC+1], pnsStringOut);
        
        pSymbols[pnsStringIn] = pnsStringOut;
//    }
    return pnsStringOut;
}





@end

