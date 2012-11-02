//
//  ViewController.h
//  WeatherAPI
//
//  Created by Kobe Dai on 10/25/12.
//  Copyright (c) 2012 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLConnectionDataDelegate, UITextFieldDelegate>

- (IBAction)queryService: (id)sender;

@end
