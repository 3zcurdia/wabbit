//
//  NSCountry.m
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/7/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import "NSCountry.h"

@implementation NSCountry

- (instancetype)initWithISO: (NSString*)iso name: (NSString*)name languanges: (NSArray*)langs
{
    self = [super init];
    if (self) {
        self.iso = iso;
        self.name = name;
        self.languages = langs;
    }
    return self;
}
@end
