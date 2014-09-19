ICGTransitionAnimation
======================

ICGTransitionAnimation is a library to customize transition animation in iOS 7.

![Demo](https://raw.githubusercontent.com/itsmeichigo/ICGTransitionAnimation/master/Demo.gif)

## Changes
v 1.02
 * Fix bug unable to show modal transition animation in storyboard.

v 1.01 
 * Fix wrong animation transition direction.
 
v 1.0
 * First public release

## Getting started

#### Using CocoaPods:
  Just add the following line in to your pod file:
  
	pod 'ICGTransitionAnimation', '~> 1.02'

#### Manually add ICGTransitionAnimation as a library:
  Drag and drop the subfolder named `ICGTransitionAnimation` in your project and you are done.

### Basic usage

 1. Custom navigation transition

 Create an instance of `ICGNavigationController` and set your preferred animation controller with corresponding transition style (default style will be used if none is set).

 ```Objective-C

	 ICGNavigationController *navigationController = [[ICGNavigationController alloc] initWithRootViewController:viewController];
	 ICGLayerAnimation *layerAnimation = [[ICGLayerAnimation alloc] initWithType:ICGLayerAnimationCover];
	 navigationController.animationController = layerAnimation;
 ```

 If you use storyboard, make sure your navigation controller's custom class is `ICGNavigationController`, just so you can set its animation controller via any of its view controller. For example, you can add this inside `viewDidLoad` method of your root view controller:

 ```Objective-C
    ICGNavigationController *fancyNavigationController = (ICGNavigationController *)self.navigationController;
    ICGLayerAnimation *layerAnimation = [[ICGLayerAnimation alloc] initWithType:ICGLayerAnimationCover];
    fancyNavigationController.animationController = layerAnimation;
 ```
 You can also take a look at the storyboard demo to find out how the library should be integrated.
 
 2. Custom modal transition

 In order to customize the modal transition animation, you need to make sure your presenting view controller subclasses `ICGViewController` and set a custom animation controller to it.

 One important note: The transition can only work if you set the modal view controller transitioning delegate to that of the presenting view controller (see the sample code below).

 ```Objective-C

	  // ICGMainViewController is a subclass of ICGViewController
    ICGMainViewController *mainController = [[ICGMainViewController alloc] initWithNibName:@"ICGFirstViewController" bundle:nil];
    ICGSlideAnimation *slideAnimation = [[ICGSlideAnimation alloc] init];
    slideAnimation.type = ICGSlideAnimationFromTop;
    mainController.animationController = slideAnimation;

    // View controller to be modally presented - this can subclass any UIViewController subclass.
    ICGModalViewController *modalController = [[ICGModalViewController alloc] initWithNibName:@"ICGModalViewController" bundle:nil];
    modalController.transitioningDelegate = mainController.transitioningDelegate; // this is important for the transition to work
    [modalController.navigationController presentViewController:viewController animated:YES completion:nil];

 ```
 3. Interactive transition

 If you are using an animation controller that supports interactive transition, make sure to enable interaction on the object that you set the animation controller to.

 ```Objective-C

    // If you want the push / pop transition to be interactive, enable interaction on your ICGNavigationController instance
    navigationController.interactionEnabled = YES;

    // If you want the modal transition to be interactive, enable interaction on the presenting view controller
    mainViewController.interactionEnabled = YES;
 ```


### Advanced usage

By default, there are several available animation controllers provided in the library for basic transition customization. You are however encouraged to create your own, creative transition style by subclassing `ICGBaseAnimation`. The idea is pretty simple - you just need to override the mandatory method `animateTransition: fromView: toView:`. If you wish to add interactive transition too, be sure to override `setInteractionEnabled`.

For sample code, check out the implementation of `ICGSlideAnimation` provided in the library, which supports both custom animation and interaction transition.

## Requirements

ICGTransitionAnimation requires Xcode 5 as it uses UIKit Dynamics and motion effects. The library
supports iOS 7, but it's also compatible for iOS 6.

### ARC

ICGTransitionAnimation uses ARC. If you are using ICGTransitionAnimation in a non-arc project, you
will need to set a `-fobjc-arc` compiler flag on every ICGTransitionAnimation source files. To set a
compiler flag in Xcode, go to your active target and select the "Build Phases" tab. Then select
ICGTransitionAnimation source files, press Enter, insert -fobjc-arc and then "Done" to enable ARC
for ICGTransitionAnimation.

## Contributing

Contributions for bug fixing or improvements are welcomed. Feel free to submit a pull request.

## Licence

ICGTransitionAnimation is available under the MIT license. See the LICENSE file for more info.
