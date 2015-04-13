//
//  SalesForceBussinessClass.h
//  salesforce
//
//  Created by Prathibha on 25/03/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SalesforceRestAPI/SFRestAPI.h>
#import <SalesforceOAuth/SFOAuthCoordinator.h>
#import <SalesforceOAuth/SFOAuthCredentials.h>
#import <SalesforceSDKCore/SFUserAccountManager.h>
#import <SalesforceSDKCore/SFAuthenticationManager.h>

@interface SalesForceBussinessClass : NSObject<SFAuthenticationManagerDelegate,SFRestDelegate>



+(id)SharedInstance;
+(BOOL)SalesforceAuthentication;
//+(NSString*)GenerateAccessToken;
+(NSString *)URLGeneration:(NSString*)requiredURL;
@end
