## Intro 

This class is a drop in way to add sharing with facebook and twitter to your iOS apps. Other methods to share 
can/will be added later. If you have a method you want to add, please fork the project, add your code and send us a pull request!

## Setup

#### Add and Setup Facebook SDK

Adding the facebook sdk is well documented [here](https://developers.facebook.com/docs/mobile/ios/build/), but I'll give you a quick outline.

1. Create an app on facebook at [https://developers.facebook.com/apps](https://developers.facebook.com/apps).
2. Add facebook-ios-sdk files to your project.
3. Add necessary code to your app delegate files, detailed [here](https://developers.facebook.com/docs/mobile/ios/build/#implementsso).
4. Make sure you remember to setup your info.plist file for Facebook SSO.

#### Add and Setup Twitter

1. Include the twitter framework in your project by adding the iOS5 Twitter framework in xcode.
2. That's all.

#### Add ShareMachine Files

1. Copy the ShareMachine.h and ShareMachine.m files to your project.
2. Change the constants in the ShareMachine.h file to reflect your facebook_app_id, and the various links/messages you want your users to share.
3. Create an instance of ShareMachine in your viewController with the initWithDelegate method. The delegate is probably the view controller. You also need to call the share methods somehow. In this example we'll use a simple UIButton (created from within Interface Builder) that will share to facebook.

		ViewController.h
		
		#import "ShareMachine.h"
		
		@interface ViewController : UIViewController <BonoboShareMachineDelegate>
		
		@property (nonatomic, strong) ShareMachine* shareMachine;
		
		@end
<br>

		ViewController.m
		
		@implementation ViewController
		
		@synthesize shareMachine;
		
		-(void)viewDidLoad {
			self.shareMachine = [[ShareMachine alloc] initWithDelegate:self];
		}
		
		-(IBAction)onShareFacebookButtonTap:(id)sender {
			[self.shareMachine shareWithFacebook];
		}
		
		@end
	

4. There are also delegate methods you can implement in the viewController if you want to do something specific when the share is finished or if the share errors out.

		ViewController.m
		
		@implementation ViewController
		
		@synthesize shareMachine;
		
		-(void)viewDidLoad {
			self.shareMachine = [[ShareMachine alloc] initWithDelegate:self];
		}
		
		-(IBAction)onShareFacebookButtonTap:(id)sender {
			[self.shareMachine shareWithFacebook];
		}
		
		-(void)didFinishSharing {
			// Do some stuff when the share action has been completed
		}
		
		-(void)didFailToShareWithError:(NSError *)error {
			// Do some stuff if the share action fails with 
			// an error (Error only works for facebook at the 
			// moment. Twitter will always return didFinishSharing).
		}
		
		@end

## Fork that junk yo!

We are always happy to see pull requests for the following things:

- Bug fixes
- New sharing methods
- Any other change that makes the code faster, cleaner, DRYer or better in any other way.

## Requirements

Right now this code is written for iOS5+ and it uses ARC (Automatic Reference Counting).

## License

Copyright (C) 2012 Bonobo [info@bonobolabs.com](mailto:info@bonobolabs.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.