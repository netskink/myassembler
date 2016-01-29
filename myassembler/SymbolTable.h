//
//  SymbolTable.h
//  myassembler
//
//  Created by John Fred Davis on 6/6/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#ifndef myassembler_SymbolTable_h
#define myassembler_SymbolTable_h


#import <Foundation/Foundation.h>

@interface SymbolTable : NSObject
{
    
    NSMutableDictionary *pSymbols;
    NSUInteger uiNextFree;
NSUInteger uiPC;
    
    
}

@property (nonatomic, retain) NSMutableDictionary *pSymbols;
@property (nonatomic) NSUInteger uiNextFree;
@property  NSUInteger uiPC;
// its like the andAnotherArg is how callers specify param2.
-(NSString *)getAddress:(NSString *) pnsStringIn result:(NSString *) pnsStringOut;
-(NSString *)getLabelAddress:(NSString *) pnsStringIn result:(NSString *) pnsStringOut;
- (id)init;


@end


#endif
