// Copyright (C) 2012 Bonobo <info@bonobolabs.com>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ShareMachine.h"

@implementation ShareMachine

@synthesize delegate;

- (id)initWithDelegate:(id)del {
    self = [super init];
    
    if (self) {
        self.delegate = del;
        // Setup listeners for facebook login
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareWithFacebook) name:@"facebookDidLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareWithFacebook) name:@"facebookDidRefreshToken" object:nil];
    }
    return self;
}

#pragma mark - Facebook Methods -

- (void)shareWithFacebook {
    if ([APP_DELEGATE.facebook isSessionValid]) {
        [self postFacebookStatus];
    }
    else {
    	// List of permissions for facebook, uncomment if you need more specific permissions
        //        NSArray *permissions = [[NSArray alloc] initWithObjects:
        //                                @"user_about_me",
        //                                @"user_likes",
        //                                @"email",
        //                                @"publish_stream",
        //                                nil];
        
        [APP_DELEGATE.facebook authorize:nil];
    }
}

- (void)postFacebookStatus {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:5];
    [params setObject:@"237183926372109" forKey:@"app_id"];
    [params setObject:@"http://bit.ly/cYD7Ro" forKey:@"link"];
    [params setObject:@"iBoost - Make your car sound turbo with your iPhone." forKey:@"name"];
    [params setObject:@"" forKey:@"caption"];
    
    [APP_DELEGATE.facebook dialog:@"feed" andParams:params andDelegate:self];
}

- (void) dialogDidComplete:(FBDialog *)dialog {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [FlurryAnalytics logEvent:@"User Shared Facebook Status"];
    [prefs setBool:YES forKey:@"sharedFacebook"];
    
    [self.delegate dismissModalViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(didFinishSharing)])
        [self.delegate didFinishSharing];  
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error {
	[self.delegate dismissModalViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(didFailToShareWithError:)])
        [self.delegate didFailToShareWithError:error];
}




#pragma mark - Twitter Methods -

- (void)shareWithTwitter {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    [twitter setInitialText:@"Make your car sound turbo with the iBoost app from @bonobolabs! http://iboostapp.com"];
    
    [self.delegate presentViewController:twitter animated:YES completion:nil];    
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        
        if(res == TWTweetComposeViewControllerResultDone) {
            [FlurryAnalytics logEvent:@"User Shared Twitter"];
            [prefs setBool:YES forKey:@"sharedTwitter"];
        }
        
        [self.delegate dismissModalViewControllerAnimated:YES];
        
        if ([self.delegate respondsToSelector:@selector(didFinishSharing)])
            [self.delegate didFinishSharing];
    };
}



@end
