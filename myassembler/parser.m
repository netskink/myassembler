//
//  parser.m
//  myassembler
//
//  Created by John Fred Davis on 6/4/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "parser.h"
#import "utils.h"
#import "Code.h"
#import "MyIO.h"
#import "SymbolTable.h"


// To be treated as literals, these must be backslashed
// * ? + [ ( ) { } ^ $ | \ . /




void parseLines(NSArray *pLines, SymbolTable *pSymbolTable) {
    
    
    @autoreleasepool {
        
        
        int i;
        enum command_type eCommandType;
        NSString *pnsDest;
        NSString *pnsComp;
        NSString *pnsJump;
        NSString *pnsSymbol;
        NSString *pnsResult;
        NSString *pnsBuffer;
        char *pchBuffer = NULL;
        
        
        Code *pCode = [[Code alloc]init];
        MyIO *pMyIO = [[MyIO alloc]init];
        
        
        
        
        for (i=0; i<pLines.count; i++) {
            
            // Init them so we don't reuse prior values
            pnsDest = NULL;
            pnsComp = NULL;
            pnsJump = NULL;
            pnsSymbol = NULL;
            pchBuffer = NULL;
            pnsResult = NULL;
            pnsBuffer = NULL;
            
            
            
            
            
            eCommandType = commandType(pLines[i]);
            
            if (SKIP != eCommandType) {
                //              NSLog(@"Source Line: %@",pLines[i]);
                pchBuffer = NStoChar(pLines[i], pchBuffer);
                printf("Source Line[%d] uipc=%d: %s\n",i+1, pSymbolTable.uiPC, pchBuffer);  // line count is 1+
            } else {
                continue;
            }
            
            if (A_COMMAND == eCommandType) {
                pnsSymbol = symbol(pLines[i], pnsSymbol);
                pchBuffer = NStoChar(pnsSymbol, pchBuffer);
                printf("\tA symbol: %s\n",pchBuffer);
                
                pnsResult = [pSymbolTable getAddress:pnsSymbol result:pnsResult];
                if (Nil != pnsResult) {
                    pchBuffer = NStoChar(pnsResult, pchBuffer);
                    printf("\t lookup: %s\n",pchBuffer);

                }
                pSymbolTable.uiPC++;
                
                continue;
                
                
                
            }
            if (L_COMMAND == eCommandType) {
                pnsSymbol = symbol(pLines[i], pnsSymbol);
                pchBuffer = NStoChar(pnsSymbol, pchBuffer);
                printf("\tL: %s\n",pchBuffer);

                pnsResult = [pSymbolTable getLabelAddress:pnsSymbol result:pnsResult];
                pchBuffer = NStoChar(pnsResult, pchBuffer);
                printf("\t lookup: %s\n",pchBuffer);

            
                continue;
            }
            
            
            if (C_COMMAND == eCommandType) {
                pSymbolTable.uiPC++;
                continue;
            }
        }
        
    } // alloc pool
    
    printf("parse1 end =========\n");

    
}





void parseLines2(NSArray *pLines, SymbolTable *pSymbolTable) {

    
    @autoreleasepool {

    
        int i;
        enum command_type eCommandType;
        NSString *pnsDest;
        NSString *pnsComp;
        NSString *pnsJump;
        NSString *pnsSymbol;
        NSString *pnsResult;
        NSString *pnsBuffer;
        NSString *pnsResult2;
        NSString *pnsBuffer2;
        char *pchBuffer = NULL;
        char *pchBuffer2 = NULL;
    

        Code *pCode = [[Code alloc]init];
        MyIO *pMyIO = [[MyIO alloc]init];
        
        
    
    
        for (i=0; i<pLines.count; i++) {

            // Init them so we don't reuse prior values
            pnsDest = NULL;
            pnsComp = NULL;
            pnsJump = NULL;
            pnsSymbol = NULL;
            
            pchBuffer = NULL;
            pnsResult = NULL;
            pnsBuffer = NULL;

            pchBuffer2 = NULL;
            pnsResult2 = NULL;
            pnsBuffer2 = NULL;

        
        
        
        
            eCommandType = commandType(pLines[i]);

            if (SKIP != eCommandType) {
//              NSLog(@"Source Line: %@",pLines[i]);
                pchBuffer = NStoChar(pLines[i], pchBuffer);
                printf("Source Line[%d]: %s\n",i+1, pchBuffer);  // line count is 1+
            
            } else {
                continue;
            }

            if (A_COMMAND == eCommandType) {
                pnsSymbol = symbol(pLines[i], pnsSymbol);
                pchBuffer = NStoChar(pnsSymbol, pchBuffer);
                printf("\tA: %s\n",pchBuffer);

                
                pnsResult2 = [pSymbolTable getAddress:pnsSymbol result:pnsResult2];
                pchBuffer2 = NStoChar(pnsResult2, pchBuffer2);
                printf("\t lookup: %s\n",pchBuffer2);
                
                

                // Add the A-Instr Leading bits and then the symbol
                [pMyIO addBits:@"0" addNewline: FALSE];

//                pnsBuffer =  CharToNS(pchBuffer2, pnsBuffer);
                // we only use last 15 bits.
                pnsBuffer = [pnsResult2 substringWithRange:NSMakeRange(1, 15)];
                // Add the jump bits (and advance to next instr)
                [pMyIO addBits:pnsBuffer addNewline: TRUE];
                continue;

        
        
            }
            if (L_COMMAND == eCommandType) {
                pnsSymbol = symbol(pLines[i], pnsSymbol);
//                pchBuffer = NStoChar(pnsSymbol, pchBuffer);
//                printf("\tL: %s\n",pchBuffer);
            }
        
        
            if (C_COMMAND == eCommandType) {

                
                // Add the C-Instr Leading bits
                [pMyIO addBits:@"111" addNewline: FALSE];


                
                
                // Then the COMP Bits
                pnsComp = comp(pLines[i], pnsComp);
                //            NSLog(@"\tComp: %@", pnsComp);
                pchBuffer = NStoChar(pnsComp, pchBuffer);
                printf("\tComp: %s\n",pchBuffer);
                
                
                pnsResult = [pCode comp:pnsComp result:pnsResult ];
                pchBuffer = NStoChar(pnsResult, pchBuffer);
                printf("\t\tComp bits: %s\n",pchBuffer);
                
                // Add the comp bits
                [pMyIO addBits:pnsResult addNewline: FALSE];
                
                
                
                // Then the DEST Bits
                pnsDest = dest(pLines[i], pnsDest);
    //            NSLog(@"\tDest: %@", pnsDest);
                pchBuffer = NStoChar(pnsDest, pchBuffer);
                printf("\tDest: %s\n",pchBuffer);
                //              [aFraction setTo: 1 over: 3];
                // -(NSString *)dest:(NSString *) pnsStringIn result:(NSString *) pnsStringOut;
                

                pnsResult = [pCode dest:pnsDest result:pnsResult ];
                pchBuffer = NStoChar(pnsResult, pchBuffer);
                printf("\t\tDest bits: %s\n",pchBuffer);
                
                // Add the dest bits
                [pMyIO addBits:pnsResult addNewline: FALSE];

                
                
                
                // Then the JUMP Bits.
                pnsJump = jump(pLines[i], pnsJump);
    //            NSLog(@"\tJump: %@", pnsJump);
                pchBuffer = NStoChar(pnsJump, pchBuffer);
                printf("\tJump: %s\n",pchBuffer);
                
                pnsResult = [pCode jump:pnsJump result:pnsResult ];
                pchBuffer = NStoChar(pnsResult, pchBuffer);
                printf("\t\tJump bits: %s\n",pchBuffer);
                
                
                // Add the jump bits (and advance to next instr)
                [pMyIO addBits:pnsResult addNewline: TRUE];

                
            }
            //NSLog(@"%u",eCommandType);
            //NSLog(@"%@",pLines[i]);
        }
            printf("dump =========\n");
            [pMyIO dump];
            printf("test =========\n");
    //        print_byte(0);
    //        print_byte(1);
    //        print_byte(2);

        
        
    } // alloc pool
    
    
}


NSUInteger determineCommandType(NSString *nsLineToSearch, NSString *nsRegEx) {
    
    NSString *searchedString = nsLineToSearch;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    // NSString *pattern = @"(@)(.*)";  // finds @number
    // NSString *pattern = @"(//)(.*)";     // finds comments
    NSString *pattern = nsRegEx;
    NSError  *error = nil;
    NSUInteger iNumMatchedGroups = 0;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern
                                                                           options:0
                                                                             error:&error];
    
    NSArray* matches = [regex matchesInString:searchedString
                                      options:0
                                        range:searchedRange];
    
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [searchedString substringWithRange:[match range]];  // match text will be all groups
//        NSLog(@"match: %@", matchText);
        
        // This is ok to do here, since that outer loop never iterates more than once.
        // Need to find out why.
        iNumMatchedGroups = match.numberOfRanges;
        
        for (NSUInteger j=1;j<match.numberOfRanges;j++) {
            // there are 0 to numberOfRanges-1 values.  0 is the entire regex match. ie. the match variable.
            // the 1 to n-1 entries are the tuples for the different paren matches
            NSRange group = [match rangeAtIndex:j]; // match is the outer loop var. rangeAtIndex is tuple: offset,length
//            NSLog(@"group: %@", [searchedString substringWithRange:group]);  // stuff in a paren is here.
        }
    }
    
    return iNumMatchedGroups;
}




NSString * symbol(NSString *pLine, NSString *pResult) {

    NSString *searchedString = pLine;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    // NSString *pattern = @"(@)(.*)";  // finds @number
    NSString *pattern = @"(@)([_A-Z0-9]*)";     // finds comments
    NSError  *error = nil;
    NSUInteger iNumMatchedGroups = 0;
    
    pResult = @"";
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern
                                                                           options:0
                                                                             error:&error];
    
    NSArray* matches = [regex matchesInString:searchedString
                                      options:0
                                        range:searchedRange];
    
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [searchedString substringWithRange:[match range]];  // match text will be all groups
        //        NSLog(@"match: %@", matchText);
        
        // This is ok to do here, since that outer loop never iterates more than once.
        // Need to find out why.
        iNumMatchedGroups = match.numberOfRanges;
        
        for (NSUInteger j=1;j<match.numberOfRanges;j++) {
            // there are 0 to numberOfRanges-1 values.  0 is the entire regex match. ie. the match variable.
            // the 1 to n-1 entries are the tuples for the different paren matches
            NSRange group = [match rangeAtIndex:j]; // match is the outer loop var. rangeAtIndex is tuple: offset,length
            //NSLog(@"group: %@", [searchedString substringWithRange:group]);  // stuff in a paren is here.
            pResult = [searchedString substringWithRange:group];
        }
    }

    // If we found something, we are done. If not, look for the other form of a symbol
    if (iNumMatchedGroups != 0) {
        return pResult;
    }

    
    searchedString = pLine;
    searchedRange = NSMakeRange(0, [searchedString length]);
    pattern = @"\\(([A-Z_0-9]+)\\)";    // finds (AXX_YY)
    error = nil;
    iNumMatchedGroups = 0;

    
    
    regex = [NSRegularExpression regularExpressionWithPattern: pattern
                                                                           options:0
                                                                             error:&error];
    
    matches = [regex matchesInString:searchedString
                                      options:0
                                        range:searchedRange];
    
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [searchedString substringWithRange:[match range]];  // match text will be all groups
        //        NSLog(@"match: %@", matchText);
        
        // This is ok to do here, since that outer loop never iterates more than once.
        // Need to find out why.
        iNumMatchedGroups = match.numberOfRanges;
        
        for (NSUInteger j=1;j<match.numberOfRanges;j++) {
            // there are 0 to numberOfRanges-1 values.  0 is the entire regex match. ie. the match variable.
            // the 1 to n-1 entries are the tuples for the different paren matches
            NSRange group = [match rangeAtIndex:j]; // match is the outer loop var. rangeAtIndex is tuple: offset,length
            //NSLog(@"group: %@", [searchedString substringWithRange:group]);  // stuff in a paren is here.
            pResult = [searchedString substringWithRange:group];
        }
    }
    
    
    
    
    return pResult;
}




NSString * dest(NSString *pLine, NSString *pResult) {
    
//    NSLog(@"%@",pLine);
    NSUInteger result;

    // Assume they don't have a dest specification
    // Null = 0
    pResult = @"";
    
    
    // Test for types of commands.
    // M    = 1
    result = determineCommandType(pLine, @"(M)(=)(.*)");
    if (4 == result) {
        pResult = @"M";
        return pResult;
    }
    // D    = 2
    result = determineCommandType(pLine, @"(D)(=)(.*)");
    if (4 == result) {
        pResult = @"D";
        return pResult;
    }
    // MD   = 3
    result = determineCommandType(pLine, @"(MD)(=)(.*)");
    if (4 == result) {
        pResult = @"MD";
        return pResult;
    }
    // A    = 4
    result = determineCommandType(pLine, @"(A)(=)(.*)");
    if (4 == result) {
        pResult = @"A";
        return pResult;
    }
    // AM   = 5
    result = determineCommandType(pLine, @"(AM)(=)(.*)");
    if (4 == result) {
        pResult = @"AM";
        return pResult;
    }
    // AD   = 6
    result = determineCommandType(pLine, @"(AD)(=)(.*)");
    if (4 == result) {
        pResult = @"AD";
        return pResult;
    }
    // AMD  = 7
    result = determineCommandType(pLine, @"(AMD)(=)(.*)");
    if (4 == result) {
        pResult = @"AMD";
        return pResult;
    }
    
    return pResult;
}




NSString * comp(NSString *pLine, NSString *pResult) {
    
//    NSLog(@"%@",pLine);

    NSUInteger result;
    
    // !D
    result = determineCommandType(pLine, @"(.*)(=)(!D)(.*)");
    if (5 == result) {
        pResult = @"!D";
        return pResult;
    }
    // !A
    result = determineCommandType(pLine, @"(.*)(=)(!A)(.*)");
    if (5 == result) {
        pResult = @"!A";
        return pResult;
    }
    
    // -D
    result = determineCommandType(pLine, @"(.*)(=)(-D)(.*)");
    if (5 == result) {
        pResult = @"-D";
        return pResult;
    }
    
    // -A
    result = determineCommandType(pLine, @"(.*)(=)(-A)(.*)");
    if (5 == result) {
        pResult = @"-A";
        return pResult;
    }
    
    // D+1
    result = determineCommandType(pLine, @"(.*)(=)(D\\+1)(.*)");
    if (5 == result) {
        pResult = @"D+1";
        return pResult;
    }
    
    // A+1
    result = determineCommandType(pLine, @"(.*)(=)(A\\+1)(.*)");
    if (5 == result) {
        pResult = @"A+1";
        return pResult;
    }
    
    // D-1
    result = determineCommandType(pLine, @"(.*)(=)(D-1)(.*)");
    if (5 == result) {
        pResult = @"D-1";
        return pResult;
    }
    
    // A-1
    result = determineCommandType(pLine, @"(.*)(=)(A-1)(.*)");
    if (5 == result) {
        pResult = @"A-1";
        return pResult;
    }
    
    // D+A
    result = determineCommandType(pLine, @"(.*)(=)(D\\+A)(.*)");
    if (5 == result) {
        pResult = @"D+A";
        return pResult;
    }
    
    // D-A
    result = determineCommandType(pLine, @"(.*)(=)(D-A)(.*)");
    if (5 == result) {
        pResult = @"D-A";
        return pResult;
    }
    
    // A-D
    result = determineCommandType(pLine, @"(.*)(=)(A-D)(.*)");
    if (5 == result) {
        pResult = @"A-D";
        return pResult;
    }
    // To be treated as literals, these must be backslashed
    // * ? + [ ( ) { } ^ $ | \ . /
    
    // D&A
    result = determineCommandType(pLine, @"(.*)(=)(D&A)(.*)");
    if (5 == result) {
        pResult = @"D&A";
        return pResult;
    }
    
    // D|A
    result = determineCommandType(pLine, @"(.*)(=)(D\\|A)(.*)");
    if (5 == result) {
        pResult = @"D|A";
        return pResult;
    }
    
    // !M
    result = determineCommandType(pLine, @"(.*)(=)(!M)(.*)");
    if (5 == result) {
        pResult = @"!M";
        return pResult;
    }
    
    // -M
    result = determineCommandType(pLine, @"(.*)(=)(-M)(.*)");
    if (5 == result) {
        pResult = @"-M";
        return pResult;
    }
    // To be treated as literals, these must be backslashed
    // * ? + [ ( ) { } ^ $ | \ . /
    
    // M+1
    result = determineCommandType(pLine, @"(.*)(=)(M\\+1)(.*)");
    if (5 == result) {
        pResult = @"M+1";
        return pResult;
    }
    
    // M-1
    result = determineCommandType(pLine, @"(.*)(=)(M-1)(.*)");
    if (5 == result) {
        pResult = @"M-1";
        return pResult;
    }
    
    // D+M
    result = determineCommandType(pLine, @"(.*)(=)(D\\+M)(.*)");
    if (5 == result) {
        pResult = @"D+M";
        return pResult;
    }
    
    // D-M
    result = determineCommandType(pLine, @"(.*)(=)(D-M)(.*)");
    if (5 == result) {
        pResult = @"D-M";
        return pResult;
    }
    
    // M-D
    result = determineCommandType(pLine, @"(.*)(=)(M-D)(.*)");
    if (5 == result) {
        pResult = @"M-D";
        return pResult;
    }
    // To be treated as literals, these must be backslashed
    // * ? + [ ( ) { } ^ $ | \ . /
    
    // D&M
    result = determineCommandType(pLine, @"(.*)(=)(D&M)(.*)");
    if (5 == result) {
        pResult = @"D&M";
        return pResult;
    }
    
    // D|M
    result = determineCommandType(pLine, @"(.*)(=)(D\\|M)(.*)");
    if (5 == result) {
        pResult = @"D|M";
        return pResult;
    }
    
    // 0
    result = determineCommandType(pLine, @"(.*)(=)(0)(.*)");
    if (5 == result) {
        pResult = @"0";
        return pResult;
    }
    // 0
    result = determineCommandType(pLine, @"=(0)");
    if (2 == result) {
        pResult = @"0";
        return pResult;
    }
    // 0
    result = determineCommandType(pLine, @"(0);");
    if (2 == result) {
        pResult = @"0";
        return pResult;
    }
    // 1
    result = determineCommandType(pLine, @"(.*)(=)(1)(.*)");
    if (5 == result) {
        pResult = @"1";
        return pResult;
    }
    // -1
    result = determineCommandType(pLine, @"(.*)(=)(-1)(.*)");
    if (5 == result) {
        pResult = @"-1";
        return pResult;
    }
    // D
    result = determineCommandType(pLine, @"(.*)(=)(D)(.*)");
    if (5 == result) {
        pResult = @"D";
        return pResult;
    }
    // D
    result = determineCommandType(pLine, @"(D);(.*)");
    if (3 == result) {
        pResult = @"D";
        return pResult;
    }
    // A
    result = determineCommandType(pLine, @"(.*)(=)(A)(.*)");
    if (5 == result) {
        pResult = @"A";
        return pResult;
    }
    // M
    result = determineCommandType(pLine, @"(.*)(=)(M)(.*)");
    if (5 == result) {
        pResult = @"M";
        return pResult;
    }
    return pResult;
}


NSString * jump(NSString *pLine, NSString *pResult) {
    
    
    
    //    NSLog(@"%@",pLine);
    NSUInteger result;
    
    // Assume they don't have a jump specification
    pResult = @"";
    
    
    
    // ;JGT
    result = determineCommandType(pLine, @"(.*)(;)(JGT)");
    if (4 == result) {
        pResult = @"JGT";
        return pResult;
    }
    // ;JEQ
    result = determineCommandType(pLine, @"(.*)(;)(JEQ)");
    if (4 == result) {
        pResult = @"JEQ";
        return pResult;
    }
    // ;JGE
    result = determineCommandType(pLine, @"(.*)(;)(JGE)");
    if (4 == result) {
        pResult = @"JGE";
        return pResult;
    }
    // ;JLT
    result = determineCommandType(pLine, @"(.*)(;)(JLT)");
    if (4 == result) {
        pResult = @"JLT";
        return pResult;
    }
    // ;JNE
    result = determineCommandType(pLine, @"(.*)(;)(JNE)");
    if (4 == result) {
        pResult = @"JNE";
        return pResult;
    }
    // ;JLE
    result = determineCommandType(pLine, @"(.*)(;)(JLE)");
    if (4 == result) {
        pResult = @"JLE";
        return pResult;
    }
    // ;JMP
    result = determineCommandType(pLine, @"(.*)(;)(JMP)");
    if (4 == result) {
        pResult = @"JMP";
        return pResult;
    }
    
    return pResult;
}




// To be treated as literals, these must be backslashed
// * ? + [ ( ) { } ^ $ | \ . /

enum command_type commandType(NSString *pLine) {

    
//    NSLog(@"%@",pLine);
    NSUInteger result;
    
    // Test for types of commands.
    
    // Blank lines can be immeditately skipped.
    if (0 == pLine.length) {
        return SKIP;
    }
    
    result = determineCommandType(pLine, @"^(//)(.*)");
    if (3 == result) {  // 0 is entire, 1 is first paren group, 2 is second paren group.
        return SKIP;
    }
    result = determineCommandType(pLine, @"(@)([A-Z_0-9]+)");
    if (3 == result) {
        return A_COMMAND;
    }
    result = determineCommandType(pLine, @"([AMD])(=)([D]\\+[A])");
    if (4 == result) {
        return C_COMMAND;
    }
    
    // To be treated as literals, these must be backslashed
    // * ? + [ ( ) { } ^ $ | \ . /
    
    result = determineCommandType(pLine, @"([0AMD]+);([A-Z]+)");  // This one worked for D;JGT
//    result = determineCommandType(pLine, @"([01AMD-!&\\+\\|]+);([A-Z]+)");  // This one did not work for D;JGT
    if (3 == result) {
        return C_COMMAND;
    }
    result = determineCommandType(pLine, @"([AMD])(=)([01AMD-!&\\+\\|]);([A-Z0-9])");
    if (5 == result) {
        return C_COMMAND;
    }
    //    result = determineCommandType(pLine, @"(/[AMD])(=)(/[01AMD-!/+&/|])");
    result = determineCommandType(pLine, @"([AMD])(=)([01AMD])");
    if (4 == result) {
        return C_COMMAND;
    }

    result = determineCommandType(pLine, @"(\\([A-Z_0-9]+\\))");
    if (2 == result) {
        return L_COMMAND;
    }
    
    
    return SKIP; // blank lines will not match
}


