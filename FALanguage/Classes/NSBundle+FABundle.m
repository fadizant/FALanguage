//
//  NSBundle+FABundle.m
//  Gloocall
//
//  Created by Fadi on 30/5/16.
//  Copyright © 2016 Apprikot. All rights reserved.
//

#import "NSBundle+FABundle.h"
#import <objc/runtime.h>
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


static const char _bundle=0;

@interface Language : NSBundle

@end

@implementation Language

-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle* bundle=objc_getAssociatedObject(self, &_bundle);
    if (!bundle)
        bundle = [NSBundle bundleWithPath:[[ NSBundle mainBundle ] pathForResource:@"Base" ofType:@"lproj" ]];
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (FABundle)
static bool languageChanged;

+(void)setLanguage:(NSString*)language
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      object_setClass([NSBundle mainBundle],[Language class]);
                  });
    
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:@"AppLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    languageChanged = YES;
    
    [self updateLayout];
}

+(void)setLanguage:(NSString*)language Bundle:(NSBundle*)bundle
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      object_setClass(bundle,[Language class]);
                  });
    
    objc_setAssociatedObject([NSBundle mainBundle], (__bridge const void * _Nonnull)(bundle), language ? [NSBundle bundleWithPath:[bundle pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:@"AppLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    languageChanged = YES;
    
    [self updateLayout];
}

+(void)updateLayout
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        [[UIView appearance] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UIViewController class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UITabBar class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UIAlertController class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
        [[UITextField appearance] setTextAlignment:[self isDeviceLanguageRightToLeft] ? NSTextAlignmentRight : NSTextAlignmentLeft] ;
    }
}

+(BOOL)languageChanged {
    return languageChanged;
}

+ (BOOL)isDeviceLanguageRightToLeft {
    NSString *Value = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppLanguage"];
    NSLocaleLanguageDirection direction = [NSLocale characterDirectionForLanguage:Value];
    return (direction == NSLocaleLanguageDirectionRightToLeft);
}

@end
