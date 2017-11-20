//
//  NSJsonParse.m
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import "NSCountry.h"
#import "NSJsonParse.h"

@implementation NSJsonParse
+(NSJsonParse* ) shared {
    static NSJsonParse *sharedNSJsonParse = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNSJsonParse = [[self alloc] init];
    });
    return sharedNSJsonParse;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSArray *) decodeAllCountriesFrom: (NSData*)jsonData
{
    NSArray *arr = [self parseArray:jsonData];
    NSMutableArray *out = [[NSMutableArray alloc] initWithCapacity:0];
    for (id object in arr) {
        if ([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* dict = object;
            NSCountry* country = [[NSCountry alloc] initWithISO:dict[@"iso"] name:dict[@"name"] languanges:dict[@"languages"]];
            [out addObject:country];
        }
    }
    return out;
}

- (NSString *) encodeAllCountriesFrom: (NSArray *)jsonArray
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:&error];
    if(error) { NSLog(@"%@", error); }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSArray *) parseArray: (NSData*)jsonData
{
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    
    if(error) { NSLog(@"%@", error); }
    
    if([object isKindOfClass:[NSArray class]])
    {
        NSArray *results = object;
        return results;
    }
    else
    {
        NSLog(@"No Array found on source");
        return @[];
    }
}
@end
