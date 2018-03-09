//
//  NSBundle+FABundle.h
//  
//
//  Created by Fadi on 30/5/16.
//  Copyright © 2016 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (FABundle)
    
/**
 *   @brief  Change application language
 *
 *   @param  language code "en,ar....etc"
 *
 *   @return void
 *
 */
+ (void)setLanguage:(NSString *)language;
    
/**
 *   @brief  Return if language changed
 *
 *   @param  none
 *
 *   @return Return if language changed
 *
 */
+ (BOOL)languageChanged;
    
/**
 *   @brief  Return language diraction
 *
 *   @param  none
 *
 *   @return Return language diraction
 *
 */
+ (BOOL)isDeviceLanguageRightToLeft;
@end
