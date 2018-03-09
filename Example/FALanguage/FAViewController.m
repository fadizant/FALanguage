//
//  FAViewController.m
//  FALanguage
//
//  Created by fadizant on 09/16/2016.
//  Copyright (c) 2016 fadizant. All rights reserved.
//

#import "FAViewController.h"
#import "FALanguage.h"
#import "FAAppDelegate.h"

@interface FAViewController ()

@end

@implementation FAViewController

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (!segue.identifier || [segue.identifier isEqualToString:@""])
        return;
    
    if ([segue.identifier isEqualToString:@"english"]) {
        [NSBundle setLanguage:@"en"];
        
    } else {
        [NSBundle setLanguage:@"ar"];
    }
    
    //reload storyboard to change language
    FAAppDelegate *appDelegate = (FAAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = [self.storyboard instantiateInitialViewController];
    [appDelegate.window makeKeyAndVisible];
    
    //push to sec view after change language
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [((UINavigationController*)appDelegate.window.rootViewController) pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:segue.destinationViewController.restorationIdentifier] animated:YES];
    });
    
    
}

@end

