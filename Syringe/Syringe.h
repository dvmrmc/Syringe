//
//  Syringe.h
//  Created by David Martin on 6/10/14.
//

#import <Foundation/Foundation.h>

@interface Syringe : NSObject

+ (void)resetClassMethod:(SEL)targetSelector
               fromClass:(Class)targetClass;

+ (void)injectClassMethod:(SEL)sourceSelector
                fromClass:(Class)sourceClass
                 toMethod:(SEL)targetSelector
                fromClass:(Class)targetClass;


@end
