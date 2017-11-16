//
//  NSStringManipulation.m
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/15/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import "NSStringManipulation.h"

@implementation NSStringManipulation
+(NSStringManipulation* ) shared {
    static NSStringManipulation *sharedNSStringManipulation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNSStringManipulation = [[self alloc] init];
    });
    return sharedNSStringManipulation;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSString *) textWithNumbersFor: (NSString*)str {
    NSString *outStr = [str stringByReplacingOccurrencesOfString: @"o" withString: @"0"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"i" withString: @"1"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"z" withString: @"2"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"e" withString: @"3"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"a" withString: @"4"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"s" withString: @"5"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"b" withString: @"6"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"t" withString: @"7"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"B" withString: @"8"];
    outStr = [outStr stringByReplacingOccurrencesOfString: @"g" withString: @"9"];
    return outStr;
}

- (NSArray<NSString *> *) matchesFor: (NSString *)regexString in: (NSString *)text {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: regexString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error != nil) {
        NSLog(@"Invalid regex: %@", error.localizedDescription);
        return @[];
    }
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    NSMutableArray<NSString*> *stringMatches = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSTextCheckingResult *match in matches) {
        NSString *subStr = [text substringWithRange:[match range]];
        [stringMatches addObject: subStr];
    }
    return stringMatches;
}
@end
