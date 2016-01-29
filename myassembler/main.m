//
//  main.m
//  myassembler
//
//  Created by John Fred Davis on 5/30/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "parser.h"
#import "SymbolTable.h"
#import "code.h"





NSArray* readGivenTextFile(const char *pchInputFileName) {

    NSFileManager *fm;
    NSString *pnsCurrentDirectoryPath;
    NSError *pError = nil;
    NSArray *pLines;
    NSString *pWords;

    
    // Convert c-str filename to nstring filename
    NSString *pnsFileName = [[NSString alloc] initWithUTF8String:pchInputFileName];// convert

    // Need to create an instance of the file manager to get the current directory path
    fm = [NSFileManager defaultManager];
    pnsCurrentDirectoryPath = [fm currentDirectoryPath];
//    NSLog(@"current directory path is %@\n", pnsCurrentDirectoryPath);

    // Override the current directory name for debugging
    pnsCurrentDirectoryPath = @"/Users/davis/progs/myassembler";
    
    // Form complete fully qualified filename
    NSString *pnsFullyQualifiedFileName = [NSString stringWithFormat:@"%@/%@", pnsCurrentDirectoryPath, pnsFileName];
//    NSLog(@"Fully qualified file name is %@\n", pnsFullyQualifiedFileName);

    // Read the fully qualified filename into an array by line
    pWords = [[NSString alloc] initWithContentsOfFile:pnsFullyQualifiedFileName
                                             encoding:NSUTF8StringEncoding error:&pError];
    if (pError != nil) {
        NSLog(@"%@",pError.description);
    }
    
    // Use the UTF-8 encoder on ASCII.
    // Now to get the individual lines, break down the string:
    pLines = [pWords componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    // Dump the lines
    // int i;
    //for (i=0; i<pLines.count; i++) {
    //    NSLog(@"%@",pLines[i]);
    //}

    return pLines;
}




int main(int argc, const char * argv[]) {
    
    NSArray *pLines = nil;
    
    
    @autoreleasepool {
        printf("MyAssembler\n");
        

//        NSLog(@"The argument count is: %d", argc);
//        for (i=0;i<argc;i++) {
//            NSLog(@"argv[%d] is: %s", i, argv[i]);
//        }

        SymbolTable *pSymbolTable = [[SymbolTable alloc]init];

        
        if (2 == argc) {
            pLines = readGivenTextFile(argv[1]);
        } else {
//            NSString *pnsFileName = @"Add.asm";
//            NSString *pnsFileName = @"Max.asm";
            NSString *pnsFileName = @"Rect.asm";
            const char *pchFileName = [pnsFileName UTF8String];
            pLines = readGivenTextFile(pchFileName);
            
            
            
        }
        
        if (nil != pLines) {
            parseLines(pLines,pSymbolTable);
            parseLines2(pLines,pSymbolTable);
        }
        
    }
    return 0;
}


