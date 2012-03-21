// Copyright (C) 2012 Bonobo <info@bonobolabs.com>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Twitter/Twitter.h>
#import "FBConnect.h"

@protocol ShareMachineDelegate <NSObject>

@optional

-(void)didFinishSharing;
-(void)didFailToShareWithError:(NSError *)error;

@end


// These are the constants that need to be changed app to app
#define facebook_app_id         xxxxxxxxx //put your fb app id here
#define facebook_link           @"Put the link you want to share on facebook here"
#define facebook_name           @"The title of the share for facebook"
#define facebook_caption        @"The long caption of your share"
#define twitter_tweet           @"Text for your tweet"

@interface ShareMachine : NSObject <FBDialogDelegate>

@property (nonatomic, weak) id delegate;

- (id)initWithDelegate:(id)del;

- (void)shareWithFacebook;
- (void)postFacebookStatus;
- (void)shareWithTwitter;

@end
