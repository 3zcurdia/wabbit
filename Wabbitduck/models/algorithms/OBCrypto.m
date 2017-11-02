//
//  OBChecksums.m
//  Wabbitduck
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import "OBCrypto.h"

@interface OBCrypto()

@end
@implementation OBCrypto : NSObject

+ (id)shared {
    static OBCrypto *sharedOBCrypto = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOBCrypto = [[self alloc] init];
    });
    return sharedOBCrypto;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

-(NSString *) sha1: (NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(NSString *) sha256: (NSString *)string{
    const char *s = [string cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)(keyData.length), digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

-(NSString *) base64: (NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

@end
