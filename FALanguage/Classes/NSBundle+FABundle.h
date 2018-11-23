//
//  NSBundle+FABundle.h
//  
//
//  Created by Fadi on 30/5/16.
//  Copyright © 2016 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (FABundle)

+ (void)setLanguage:(NSString *)language;

+ (void)setLanguage:(NSString *)language Bundle:(NSBundle *)bundle;

+ (BOOL)languageChanged;

+ (BOOL)isDeviceLanguageRightToLeft;
@end
