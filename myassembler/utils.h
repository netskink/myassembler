//
//  utils.h
//  myassembler
//
//  Created by John Fred Davis on 6/4/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//

#ifndef myassembler_utils_h
#define myassembler_utils_h


char * NStoChar(NSString *pnsBuffer, char *pchBuffer);
NSString * CharToNS(char *pchBuffer, NSString *pnsBuffer);

//const char *bit_rep[16];
extern const char *bit_rep[2048];
    


#endif
