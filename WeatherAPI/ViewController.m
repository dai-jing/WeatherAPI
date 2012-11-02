//
//  ViewController.m
//  WeatherAPI
//
//  Created by Kobe Dai on 10/25/12.
//  Copyright (c) 2012 Jing Dai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *responseData;
    NSURL *theURL;
    NSString *zipCode;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)queryService:(id)sender
{
    NSString *url = [NSString stringWithFormat: @"http://api.wunderground.com/api/bb4adda5d3b86ec4/conditions/q/%@.json", zipCode];
    theURL = [NSURL URLWithString: url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: theURL];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: request delegate: self];
    if (connection)
    {
        responseData = [[NSMutableData alloc] init];
    }
    else
    {
        NSLog(@"Failed");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    zipCode = [textField text];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark NSURLConnection Data Delegate Methods

- (void)connection: (NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength: 0];
}

- (void)connection: (NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData: data];
}

- (void)connectionDidFinishLoading: (NSURLConnection *)connection
{
    // Insert code to parse the content here...
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableLeaves error: &myError];
    NSArray *results = [res objectForKey: @"current_observation"];
    NSArray *cur = [results valueForKey: @"weather"];
    NSArray *tmp = [results valueForKey: @"temp_c"];
    
    if (cur == nil || tmp == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Errors"
                              message: @"Please check your zip code"
                              delegate: self
                              cancelButtonTitle: nil
                              otherButtonTitles: @"OK", nil];
        [alert show];
    }
    else
    {
        NSString *message = [NSString stringWithFormat: @"Current Weather Conditions: %@, Current Tmp: %@", cur, tmp];
    
        UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"This is your local weather condition"
                          message: message
                          delegate: self
                          cancelButtonTitle: nil
                          otherButtonTitles: @"OK", nil];
        [alert show];
    }
}

@end
