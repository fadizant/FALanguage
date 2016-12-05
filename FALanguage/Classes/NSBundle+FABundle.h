//
//  NSBundle+FABundle.h
//  Gloocall
//
//  Created by Fadi on 30/5/16.
//  Copyright © 2016 Apprikot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (FABundle)

+ (void)setLanguage:(NSString *)language;
+ (BOOL)languageChanged;
+ (BOOL)isDeviceLanguageRightToLeft;
+ (void)updateLayout;
@end
