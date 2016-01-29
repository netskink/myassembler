//
//  io.h
//  myassembler
//
//  Created by John Fred Davis on 6/5/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#ifndef myassembler_io_h
#define myassembler_io_h


#import <Foundation/Foundation.h>

@interface MyIO: NSObject
{
    NSUInteger niCurrentEntry;
    NSString *pnsFileName; // The name of the output file.
    NSMutableArray *someArray;
}
@property (nonatomic) NSUInteger niCurrentEntry;
@property (nonatomic, retain) NSString *pnsFileName;
@property (nonatomic, retain) NSMutableArray *someArray;

- (id)init;
-(BOOL)addBits:(NSString *)bits addNewline:(Boolean)bAddNewLine;
- (void) dump;


@end

#endif
