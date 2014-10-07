//
//  Syringe.m
//  Created by David Martin on 6/10/14.
//

#import "Syringe.h"
#import <objc/runtime.h>

static NSMutableDictionary *_originalStaticMethods;

@interface Syringe ()

@end

@implementation Syringe

#pragma mark originalStaticMethods

+ (NSMutableDictionary*)originalStaticMethods
{
    if(_originalStaticMethods == nil)
    {
        _originalStaticMethods = [[NSMutableDictionary alloc] init];
    }
    return _originalStaticMethods;
}

+ (void)setOriginalStaticMethods:(NSMutableDictionary*)originalStaticMethods
{
    _originalStaticMethods = originalStaticMethods;
}

+ (void)setStaticMethod:(Method)method implementation:(IMP)methodImplementation
{
    NSMutableDictionary *originals = [Syringe originalStaticMethods];
        
    NSValue *methodValue = [NSValue valueWithPointer:method];
    NSValue *methodImplementationValue = [NSValue valueWithPointer:methodImplementation];
    
    [originals setObject:methodImplementationValue forKey:methodValue];
    [Syringe setOriginalStaticMethods:originals];
}

+ (IMP)staticImplementationForMethod:(Method)originalMethod
{
    IMP result = nil;
    
    NSValue *originalMethodValue = [NSValue valueWithPointer:originalMethod];
    NSValue *originalIMPValue = [[Syringe originalStaticMethods] objectForKey:originalMethodValue];
    
    if(originalIMPValue)
    {
        result = [originalIMPValue pointerValue];
    }
    
    return result;
}

#pragma mark - PUBLIC -

+ (void)resetClassMethod:(SEL)targetSelector
               fromClass:(Class)targetClass
{
    Method originalMethod = class_getClassMethod(targetClass, targetSelector);
    if(originalMethod)
    {
        IMP originalIMP = [Syringe staticImplementationForMethod:originalMethod];
        if(originalIMP)
        {
            method_setImplementation(originalMethod, originalIMP);
        }
    }
    else
    {
        @throw [NSException exceptionWithName:@"NotStaticSelector"
                                       reason:@"The provided method is not recognized in the class"
                                     userInfo:nil];
    }
}

+ (void)injectClassMethod:(SEL)sourceSelector
                fromClass:(Class)sourceClass
                 toMethod:(SEL)targetSelector
                fromClass:(Class)targetClass
{
    Method targetMethod = class_getClassMethod(targetClass, targetSelector);
    Method sourceMethod = class_getClassMethod(sourceClass, sourceSelector);
    
    if(targetMethod && sourceMethod)
    {
        IMP targetImplementation = [Syringe staticImplementationForMethod:targetMethod];
        if(!targetImplementation)
        {
            targetImplementation = method_getImplementation(targetMethod);
            [Syringe setStaticMethod:targetMethod implementation:targetImplementation];
        }
        
        IMP sourceImplementation = method_getImplementation(sourceMethod);
        method_setImplementation(targetMethod, sourceImplementation);
    }
    else
    {
        @throw [NSException exceptionWithName:@"NotStaticSelector"
                                       reason:@"The provided method is not recognized in the class"
                                     userInfo:nil];
    }
}

@end
