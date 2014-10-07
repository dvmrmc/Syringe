Syringe
=======

Objective-C Srynge to help with method injection

## Install
Download the source code, clone it or submodule it. Everything you need is under "Syringe" folder. Drag & Drop it to your project to start working with this tasty code.

## Usage

You can modify any class method implementation using the 'injectedClassMethod:fromClass:toMethod:fromClass:'

```objectivec
[Syringe injectClassMethod:@selector(<SOURCE_METHOD_SELECTOR>)
                 fromClass:[<SOURCE_METHOD_CLASS> class]
                  toMethod:@selector(<TARGET_METHOD_SELECTOR>)
                 fromClass:[<TARGET_METHOD_CLASS> class]];
```

You can restore any modification by invoking the 'restoreClassMethod:fromClass:'

```objectivec
[Syringe resetClassMethod:@selector(<TARGET_METHOD_SELECTOR>
                fromClass:[<TARGET_METHOD_CLASS> class]];
```

## Author
* Created by [David Martin](http://www.github.com/cerberillo)

## License 
This library is released under MIT License