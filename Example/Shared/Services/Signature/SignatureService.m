//
//  SignatureService.m
//  ThreadsApp
//
//  Created by Brooma Service on 02/04/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

#import "SignatureService.h"

static NSString * const kAPI = @"api";
static NSString * const kSignatureEndpoint = @"auth/getSignature";
static NSString * const kSignatureResponseKey = @"encodedSignature";
static BOOL const kIsDebugLoggingEnabled = YES;

NSString * const kTHRConfigDictKey = @"THR_APP_CONFIG";
NSString * const kTHRServerUrlKey = @"THR_SERVER_URL";

NSTimeInterval const kTHRSignatureRequestTimeOut = 2;

@implementation SignatureService

+ (instancetype)sharedInstance {
    static SignatureService* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getSignatureForClientId:(NSString *)clientId withCompletion:(THRClientIdSignatureCompletion)completion {
    
    if (!self.serverURL) {
        NSError *error = [self errorWithLocalizedDescription:NSLocalizedString(@"Signature URL is nil", @"")];
        completion(nil, error);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?clientId=%@", kAPI, kSignatureEndpoint, clientId]
                        relativeToURL:self.serverURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:kTHRSignatureRequestTimeOut];
    [self logRequest:request];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [self logResponse:response withData:data];
        if (connectionError) {
            [self logError:connectionError category:@"CONNECTION"];
            completion(nil, connectionError);
        } else {
            [self serializeResponseWithData:data completion:completion];
        }
    }];
}

- (void)serializeResponseWithData:(NSData * _Nullable)data completion:(THRClientIdSignatureCompletion)completion {
    NSError *serializationError;
    id JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
    if (serializationError) {
        [self logError:serializationError category:@"SERIALIZATION"];
        completion(nil, serializationError);
    } else {
        NSString *signature = JSON[kSignatureResponseKey];
        if (signature.length) {
            completion(signature, nil);
        } else {
            NSError *signatureError = [self errorWithLocalizedDescription:NSLocalizedString(@"clientSignature is absent or empty", "")];
            [self logError:signatureError category:@"SIGNATURE"];
            completion(nil, signatureError);
        }
    }
}

- (void)logRequest:(NSURLRequest *)request {
    if (kIsDebugLoggingEnabled) {
        NSLog(@"SignatureService: REQUEST = %@", request);
        NSLog(@"SignatureService: REQUEST HTTP HEADER FIELDS = %@", request.allHTTPHeaderFields);
    }
}

- (void)logResponse:(NSURLResponse *)response withData:(nullable NSData *)data {
    if (kIsDebugLoggingEnabled) {
        NSLog(@"SignatureService: RESPONSE = %@", response);
        NSLog(@"SignatureService: RESPONSE DATA = %@", data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : NSLocalizedString(@"Empty", ""));
    }
}

- (void)logError:(NSError *)error category:(NSString *)category {
    NSLog(@"SignatureService: %@ ERROR = %@", category, error.localizedDescription);
}

- (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription {
    return [NSError errorWithDomain:[[NSBundle bundleForClass:[self class]] bundleIdentifier]
                               code:0
                           userInfo:@{NSLocalizedDescriptionKey: localizedDescription}];
}

@end
