# SwiftUI-animations-objects-templates
 <h1>Collection of SwiftUI objects and animations templates 👨‍💻</h1>

This repository aims to provide a collection of SwiftUI templates that allow you to create various objects and animations in your iOS, iPadOS, or MacOS applications. You can use them however you like, and I will be adding some animations from time to time. If you wish, you can also enhance certain code snippets to make them visually more appealing or more descriptive. It's under the MIT license, so you're free to use this repository as you see fit. Enjoy and may the code be with you 🤙
Currently, there is only one picker view available that allows selecting reactions or even responding through comments. However, I will keep this repository up to date based on the experiments I conduct from time to time with SwiftUI. Feel free to subscribe to stay updated with the latest news and regularly follow the latest additions to this repository.

<h3>The Picker Reaction</h3>
<hr>
It's a simple menu that has an enum, to which we assign an id allowing to then use tags when images are used to click on a reaction defined in the picker. It is possible to modify the apnce of this picker via a separate view which will use a Binding.

 <img src="assets/Simulator Screen Recording - iPhone 14 Pro - 2023-06-22 at 11.48.14.gif" width="200" height="auto">

<h3>Buttons with particle effect</h3>
<hr>
Here it is a little more complex. We use three views and a model composed of a structure allowing to attribute the basic values ​​to the future animation which will occur once the button is clicked. We then configure the buttons that will be created as well as their design in the "MainView" view. It is here that we also specify that we expect a tap on the button to trigger an animation. The one that will be created in the "Particule Effect" view. In the latter we provide x and y values ​​to generate the animation flow that will spring from an x ​​and y of the button when it is activated by the user.
<strong>There is no need for any package or specific add-on </strong> to recreate this animation, it works as long as you use system images or configure personal ones, remembering to adapt the structure appropriately.

 <img src="assets/Simulator Screen Recording - iPhone 14 Pro - 2023-06-22 at 11.42.36.gif" width="200" height="auto">

    
<h3>📸 Web Image Gallery</h3>
<hr>
A page that allows images to be displayed via URL, via an asyncImage method available on SwiftUI. The user also has the option of clicking on each image to preview it at the maximum size of their screen.

<img src="assets/Simulator Screen Recording - iPhone 14 Pro - 2023-06-23 at 21.36.58.gif" width="200" height="auto">


