//
//  parser.h
//  myassembler
//
//  Created by John Fred Davis on 6/4/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#ifndef myassembler_parser_h
#define myassembler_parser_h


// New Types
enum command_type { A_COMMAND, C_COMMAND, L_COMMAND, SKIP };


// FUNCTION PROTOTYPES
enum command_type commandType(NSString *pLine);
NSString * dest(NSString *pLine, NSString *pResult);
NSString * comp(NSString *pLine, NSString *pResult);
NSString * jump(NSString *pLine, NSString *pResult);
NSString * symbol(NSString *pLine, NSString *pResult);


#import "SymbolTable.h"
void parseLines(NSArray *pLines, SymbolTable *pSymbolTable);
void parseLines2(NSArray *pLines, SymbolTable *pSymbolTable);


#endif
