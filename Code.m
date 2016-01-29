//
//  code.m
//  myassembler
//
//  Created by John Fred Davis on 6/4/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Code.h"
@implementation Code

@synthesize someVariable;
@synthesize someOtherVariable;

-(void)someMethod
{
    // body of method
}
-(BOOL)someOtherMethodWithArg:(NSString *)param andAnotherArg:(int)param2
{
    // body of method
    return TRUE;
}

-(NSString *)dest:(NSString *) pnsStringIn result:(NSString *) pnsStringOut
{
    // Null = 0
    pnsStringOut = @"000"; // assume dest is null
    
    // M    = 1
    if ([pnsStringIn isEqualToString:@"M"]) {
        pnsStringOut = @"001";
        return pnsStringOut;
    }
    // D    = 2
    if ([pnsStringIn isEqualToString:@"D"]) {
        pnsStringOut = @"010";
        return pnsStringOut;
    }
    // MD   = 3
    if ([pnsStringIn isEqualToString:@"MD"]) {
        pnsStringOut = @"011";
        return pnsStringOut;
    }
    // A    = 4
    if ([pnsStringIn isEqualToString:@"A"]) {
        pnsStringOut = @"100";
        return pnsStringOut;
    }
    // AM   = 5
    if ([pnsStringIn isEqualToString:@"AM"]) {
        pnsStringOut = @"101";
        return pnsStringOut;
    }
    // AD   = 6
    if ([pnsStringIn isEqualToString:@"AD"]) {
        pnsStringOut = @"110";
        return pnsStringOut;
    }
    // AMD  = 7
    if ([pnsStringIn isEqualToString:@"AMD"]) {
        pnsStringOut = @"111";
        return pnsStringOut;
    }

    
    return pnsStringOut;
}

-(NSString *)comp:(NSString *) pnsStringIn result:(NSString *) pnsStringOut
{

    pnsStringOut = @"-------"; // assume an invalid state
    


    
    
    //-=0;-				0	1	0	1	0	1	0
    if ([pnsStringIn isEqualToString:@"0"]) {
        pnsStringOut = @"0101010";
        return pnsStringOut;
    }
    //-=1;-				0	1	1	1	1	1	1
    if ([pnsStringIn isEqualToString:@"1"]) {
        pnsStringOut = @"0111111";
        return pnsStringOut;
    }
    //-=-1;-			0	1	1	1	0	1	0
    if ([pnsStringIn isEqualToString:@"-1"]) {
        pnsStringOut = @"0111010";
        return pnsStringOut;
    }
    //-=D;-				0	0	0	1	1	0	0
    if ([pnsStringIn isEqualToString:@"D"]) {
        pnsStringOut = @"0001100";
        return pnsStringOut;
    }
    //-=A;-				0	1	1	0	0	0	0
    if ([pnsStringIn isEqualToString:@"A"]) {
        pnsStringOut = @"0110000";
        return pnsStringOut;
    }
    //-=!D;-			0	0	0	1	1	0	1
    if ([pnsStringIn isEqualToString:@"!D"]) {
        pnsStringOut = @"0001101";
        return pnsStringOut;
    }
    //-=!A;-			0	1	1	0	0	0	1
    if ([pnsStringIn isEqualToString:@"!A"]) {
        pnsStringOut = @"0110001";
        return pnsStringOut;
    }
    //-=-D;-			0	0	0	1	1	1	1
    if ([pnsStringIn isEqualToString:@"-D"]) {
        pnsStringOut = @"0001111";
        return pnsStringOut;
    }
    //-=-A;-			0	1	1	0	0	1	1
    if ([pnsStringIn isEqualToString:@"-A"]) {
        pnsStringOut = @"0110011";
        return pnsStringOut;
    }
    //-=D+1;-			0	0	1	1	1	1	1
    if ([pnsStringIn isEqualToString:@"D+1"]) {
        pnsStringOut = @"0011111";
        return pnsStringOut;
    }
    //-=A+1;-			0	1	1	0	1	1	1
    if ([pnsStringIn isEqualToString:@"A+1"]) {
        pnsStringOut = @"0110111";
        return pnsStringOut;
    }
    //-=D-1;-			0	0	0	1	1	1	0
    if ([pnsStringIn isEqualToString:@"D-1"]) {
        pnsStringOut = @"0001110";
        return pnsStringOut;
    }
    //-=A-1;-			0	1	1	0	0	1	0
    if ([pnsStringIn isEqualToString:@"A-1"]) {
        pnsStringOut = @"0110010";
        return pnsStringOut;
    }
    //-=D+A;-           0	0	0	0	0	1	0
    if ([pnsStringIn isEqualToString:@"D+A"]) {
        pnsStringOut = @"0000010";
        return pnsStringOut;
    }
    //-=D-A;-			0	0	1	0	0	1	1
    if ([pnsStringIn isEqualToString:@"D-A"]) {
        pnsStringOut = @"0010011";
        return pnsStringOut;
    }
    //-=A-D;-			0	0	0	0	1	1	1
    if ([pnsStringIn isEqualToString:@"A-D"]) {
        pnsStringOut = @"0000111";
        return pnsStringOut;
    }
    //-=D&A;-			0	0	0	0	0	0	0
    if ([pnsStringIn isEqualToString:@"D&A"]) {
        pnsStringOut = @"0000000";
        return pnsStringOut;
    }
    //-=D|A;-			0	0	1	0	1	0	1
    if ([pnsStringIn isEqualToString:@"D|A"]) {
        pnsStringOut = @"0010101";
        return pnsStringOut;
    }
    //-=M;-				1	1	1	0	0	0	0
    if ([pnsStringIn isEqualToString:@"M"]) {
        pnsStringOut = @"1110000";
        return pnsStringOut;
    }
    //-=!M;-			1	1	1	0	0	0	1
    if ([pnsStringIn isEqualToString:@"!M"]) {
        pnsStringOut = @"1110001";
        return pnsStringOut;
    }
    //-=-M;-			1	1	1	0	0	1	1
    if ([pnsStringIn isEqualToString:@"-M"]) {
        pnsStringOut = @"1110011";
        return pnsStringOut;
    }
    //-=M+1;-			1	1	1	0	1	1	1
    if ([pnsStringIn isEqualToString:@"M+1"]) {
        pnsStringOut = @"1110111";
        return pnsStringOut;
    }
    //-=M-1;-			1	1	1	0	0	1	0
    if ([pnsStringIn isEqualToString:@"M-1"]) {
        pnsStringOut = @"1110010";
        return pnsStringOut;
    }
    //-=D+M;-			1	0	0	0	0	1	0
    if ([pnsStringIn isEqualToString:@"D+M"]) {
        pnsStringOut = @"1000010";
        return pnsStringOut;
    }
    //-=D-M;-			1	0	1	0	0	1	1
    if ([pnsStringIn isEqualToString:@"D-M"]) {
        pnsStringOut = @"1010011";
        return pnsStringOut;
    }
    //-=M-D;-			1	0	0	0	1	1	1
    if ([pnsStringIn isEqualToString:@"M-D"]) {
        pnsStringOut = @"1000111";
        return pnsStringOut;
    }
    //-=D&M;-			1	0	0	0	0	0	0
    if ([pnsStringIn isEqualToString:@"D&M"]) {
        pnsStringOut = @"1000000";
        return pnsStringOut;
    }
    //-=D|M;-			1	0	1	0	1	0	1
    if ([pnsStringIn isEqualToString:@"D|M"]) {
        pnsStringOut = @"1010101";
        return pnsStringOut;
    }
    
    return pnsStringOut;
}


-(NSString *)jump:(NSString *) pnsStringIn result:(NSString *) pnsStringOut
{
    
    
    
    
    
    // Null = 0
    // 								0	0	0
    pnsStringOut = @"000"; // assume dest is null
    
    //    ;JGT						0	0	1
    if ([pnsStringIn isEqualToString:@"JGT"]) {
        pnsStringOut = @"001";
        return pnsStringOut;
    }
    //    ;JEQ						0	1	0
    if ([pnsStringIn isEqualToString:@"JEQ"]) {
        pnsStringOut = @"010";
        return pnsStringOut;
    }
    //    ;JGE						0	1	1
    if ([pnsStringIn isEqualToString:@"JGE"]) {
        pnsStringOut = @"011";
        return pnsStringOut;
    }
    //    ;JLT						1	0	0
    if ([pnsStringIn isEqualToString:@"JLT"]) {
        pnsStringOut = @"100";
        return pnsStringOut;
    }
    //    ;JNE						1	0	1
    if ([pnsStringIn isEqualToString:@"JNE"]) {
        pnsStringOut = @"101";
        return pnsStringOut;
    }
    //    ;JLE						1	1	0
    if ([pnsStringIn isEqualToString:@"JLE"]) {
        pnsStringOut = @"110";
        return pnsStringOut;
    }
    //    ;JMP						1	1	1
    if ([pnsStringIn isEqualToString:@"JMP"]) {
        pnsStringOut = @"111";
        return pnsStringOut;
    }

    
    return pnsStringOut;
}



@end