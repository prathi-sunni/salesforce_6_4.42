//
//  SalesForceBussinessClass.m
//  salesforce
//
//  Created by Prathibha on 25/03/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import "SalesForceBussinessClass.h"
static NSString * const kOAuthConsumerKey = @"3MVG9Y6d_Btp4xp4Q5L1TV0uyT1TDoKU19PhDWsKdzC2i1SDNMwQua7EKxWXf5HSBKz_omZLE1.T71SYYZuoF";
static NSString * const kOAuthRedirectURI = @"https://buddy.ap1.visual.force.com/apex/Task_vf";

@implementation SalesForceBussinessClass

 static NSString *token = nil;
+(id)SharedInstance
{
    static SalesForceBussinessClass *salesforce = nil;
   
    if(salesforce == nil)
    {
        
        salesforce = [[self alloc]init];
        [SalesForceBussinessClass SalesforceAuthentication];
        
        
        
    }
    return salesforce;
}

+(BOOL)SalesforceAuthentication
{
    [SFUserAccountManager sharedInstance].oauthClientId = kOAuthConsumerKey;
    
    [SFUserAccountManager sharedInstance].oauthCompletionUrl = kOAuthRedirectURI;
    
    [SFUserAccountManager sharedInstance].scopes = [NSSet setWithObjects:@"web", @"api", nil];
    
//    [[SFAuthenticationManager sharedManager] addDelegate:self];
    
    
    [[SFAuthenticationManager sharedManager]
     loginWithCompletion:(SFOAuthFlowSuccessCallbackBlock)^(SFOAuthInfo *info) {
         
         NSLog(@"Authentication Done");
         token = [SFAuthenticationManager sharedManager].coordinator.credentials.accessToken;
         
         return TRUE;
     }
     failure:(SFOAuthFlowFailureCallbackBlock)^(SFOAuthInfo *info, NSError *error) {
         NSLog(@"Authentication Failed");
         // handle error hare.
         return FALSE;
     }
     ];
    
    return FALSE;

}

//+(NSString*)GenerateAccessToken
//{
//    if([self SalesforceAuthentication] == TRUE)
//    {
//        return token;
//    }
//    return  nil;
//}

+(NSString *)URLGeneration:(NSString*)requiredURL
{
    
    if(token != nil)
        return [NSString stringWithFormat:@"https://ap1.salesforce.com/secur/frontdoor.jsp?sid=%@&retURL=%@",token,requiredURL];
    
    else
        return nil;
}

@end
