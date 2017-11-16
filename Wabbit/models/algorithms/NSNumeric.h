//
//  NSNumeric.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#include "math.h"
#import <Foundation/Foundation.h>

@interface NSNumeric : NSObject
+(NSNumeric *) shared;
-(long) factorialLong: (long)input;
-(BOOL) isPrimeLong: (long)input;
-(long)fibonacci:(long)position;
@end
