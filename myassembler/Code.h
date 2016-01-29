//
//  code.h
//  myassembler
//
//  Created by John Fred Davis on 6/4/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#ifndef myassembler_code_h
#define myassembler_code_h


#import <Foundation/Foundation.h>
@interface Code : NSObject
{
    NSString *someVariable;
    NSString *someOtherVariable;
    NSArray *someArray;
}
@property (nonatomic, retain) NSString *someVariable;
@property (nonatomic, retain) NSString *someOtherVariable;
-(void)someMethod;
-(BOOL)someOtherMethodWithArg:(NSString *)param andAnotherArg:(int)param2;

// its like the andAnotherArg is how callers specify param2.
-(NSString *)dest:(NSString *) pnsStringIn result:(NSString *) pnsStringOut;

-(NSString *)comp:(NSString *) pnsStringIn result:(NSString *) pnsStringOut;

-(NSString *)jump:(NSString *) pnsStringIn result:(NSString *) pnsStringOut;


@end



#endif
