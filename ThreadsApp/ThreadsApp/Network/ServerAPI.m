//
//  ServerAPI.m
//  ThreadsApp
//
//  Created by Brooma Service on 02/04/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

#import "ServerAPI.h"
#import "ConfigHelper.h"

static NSString* const kAPI = @"api/";
static NSString* const kSignatureEndpoint = @"auth/getSignature/";
static NSString* const kSignatureResponseKey = @"encodedSignature";
static BOOL const kIsDebugLoggingEnabled = YES;

@implementation ServerAPI

+ (void) getClientIdSignature: (NSString*) clientId withCompletion: (THRClientIdSignatureCompletion) completion {
    
    NSString* baseUrl = [ConfigHelper getServerUrl];
    
    if (baseUrl.length) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@?clientId=%@",
                               baseUrl, kAPI, kSignatureEndpoint, clientId];
        
        [self loadSignatureWithURL: urlString
                        completion: completion];
        
    } else {
        NSLog(@"Signature loading failed: Server url empty");
    }
}

+ (void) loadSignatureWithURL: (NSString *) url
                   completion: (THRClientIdSignatureCompletion) completion {
    
    NSMutableURLRequest * request = [self request: url];
    
    if (kIsDebugLoggingEnabled) {
        NSLog(@"Load signature: REQUEST = %@", request);
        NSLog(@"Load signature: HEADERS = %@", request.allHTTPHeaderFields);
    }
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue currentQueue]
                           completionHandler: 
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         
         if (kIsDebugLoggingEnabled) {
             NSLog(@"Load signature: RESPONSE = %@", response);
             NSLog(@"Load signature: DATA     = %@",
                   data ? [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding] : data);
         }
         
         if (error) {
             NSLog(@"Load signature: ERROR    = %@", error);
             completion(nil, error);
         } else {
             NSError *jsonError;
             id json = [NSJSONSerialization JSONObjectWithData:data options: kNilOptions error: &jsonError];
             if (jsonError) {
                 NSLog(@"Load signature: ERROR    = %@", jsonError);
                 completion(nil, jsonError);
             } else {
                 NSString* signature = json[kSignatureResponseKey];
                 if (signature.length) {
                     completion(signature, nil);
                 } else {
                     NSError* signatureDataError = [NSError errorWithDomain:[[NSBundle bundleForClass:[self class]] bundleIdentifier]
                                                                       code:0
                                                                   userInfo:@{@"error_description" : @"clientSignature is absent or empty"}];
                     NSLog(@"Load signature: ERROR    = %@", signatureDataError);
                     completion(nil, signatureDataError);
                 }
             }
         }
     }];
}

+ (NSMutableURLRequest *) request: (NSString *) urlString {
    
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest* signatureRequest = [NSMutableURLRequest requestWithURL: url
                                                                    cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                                timeoutInterval: 30];
    [signatureRequest setHTTPMethod: @"GET"];
    return signatureRequest;
}

@end
