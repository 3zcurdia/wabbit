//
//  NSNumeric.m
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import "NSNumeric.h"

@implementation NSNumeric
+(NSNumeric *) shared {
    static NSNumeric *sharedNSNumeric = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNSNumeric = [[self alloc] init];
    });
    return sharedNSNumeric;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

-(long) factorialLong: (long)input {
    if (input < 1) {
        return 1;
    } else {
        return input * [self factorialLong: input-1];
    }
}

-(BOOL) isPrimeLong: (long)input{
    if (input < 2) { return NO; }
    if (input == 3) { return YES; }
    long max = sqrt((double)input);
    for(long n = 2; n <= max; n++){
        if (input % n == 0) {
            return NO;
        }
    }
    return YES;
}
@end
