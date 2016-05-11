//
//  FKFlickrPhotosDelete.m
//  FlickrKit
//
//  Generated by FKAPIBuilder.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrPhotosDelete.h" 

@implementation FKFlickrPhotosDelete



- (BOOL) needsLogin {
    return YES;
}

- (BOOL) needsSigning {
    return YES;
}

- (FKPermission) requiredPerms {
    return 2;
}

- (NSString *) name {
    return @"flickr.photos.delete";
}

- (BOOL) isValid:(NSError **)error {
    BOOL valid = YES;
	NSMutableString *errorDescription = [[NSMutableString alloc] initWithString:@"You are missing required params: "];
	if(!self.photo_id) {
		valid = NO;
		[errorDescription appendString:@"'photo_id', "];
	}

	if(error != NULL) {
		if(!valid) {	
			NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorDescription};
			*error = [NSError errorWithDomain:FKFlickrKitErrorDomain code:FKErrorInvalidArgs userInfo:userInfo];
		}
	}
    return valid;
}

- (NSDictionary *) args {
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
	if(self.photo_id) {
		[args setValue:self.photo_id forKey:@"photo_id"];
	}

    return [args copy];
}

- (NSString *) descriptionForError:(NSInteger)error {
    switch(error) {
		case FKFlickrPhotosDeleteError_PhotoNotFound:
			return @"Photo not found";
		case FKFlickrPhotosDeleteError_SSLIsRequired:
			return @"SSL is required";
		case FKFlickrPhotosDeleteError_InvalidSignature:
			return @"Invalid signature";
		case FKFlickrPhotosDeleteError_MissingSignature:
			return @"Missing signature";
		case FKFlickrPhotosDeleteError_LoginFailedOrInvalidAuthToken:
			return @"Login failed / Invalid auth token";
		case FKFlickrPhotosDeleteError_UserNotLoggedInOrInsufficientPermissions:
			return @"User not logged in / Insufficient permissions";
		case FKFlickrPhotosDeleteError_InvalidAPIKey:
			return @"Invalid API Key";
		case FKFlickrPhotosDeleteError_ServiceCurrentlyUnavailable:
			return @"Service currently unavailable";
		case FKFlickrPhotosDeleteError_WriteOperationFailed:
			return @"Write operation failed";
		case FKFlickrPhotosDeleteError_FormatXXXNotFound:
			return @"Format \"xxx\" not found";
		case FKFlickrPhotosDeleteError_MethodXXXNotFound:
			return @"Method \"xxx\" not found";
		case FKFlickrPhotosDeleteError_InvalidSOAPEnvelope:
			return @"Invalid SOAP envelope";
		case FKFlickrPhotosDeleteError_InvalidXMLRPCMethodCall:
			return @"Invalid XML-RPC Method Call";
		case FKFlickrPhotosDeleteError_BadURLFound:
			return @"Bad URL found";
  
		default:
			return @"Unknown error code";
    }
}

@end
