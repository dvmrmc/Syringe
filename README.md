Syringe
=======

![license](http://img.shields.io/badge/license-MIT-red.svg?style=flat)
![platform](http://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)

Objective-C Syringe for Injection. This library will help you changing method implementation in a class at run time. 

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

## Contributing
Feel free to add new features by pullrequesting.

## License 
This library is released under MIT License
