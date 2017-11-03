//
//  OBNumeric.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#include "math.h"
#import <Foundation/Foundation.h>

@interface OBNumeric : NSObject
+(id) shared;
-(long) factorialLong: (long)input;
-(BOOL) isPrimeLong: (long)input;
@end
