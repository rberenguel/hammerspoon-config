## Some hammerspoon configuration

I decided to stop using [Amethyst](https://ianyh.com/amethyst/) (even if I _love it_) because although automated
window layouts rock, the lack of overlapping windows in Amethyst makes using it problematic, particularly with only one screen. It forces you to use multiple desktops, and I'm not particularly a fan of this solution.

To mimic more or less my Amethyst usage, I borrowed the window management from [this post](https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888) (code available [here](https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/window-management.lua)) and the code from this [move-resize snippet](https://gist.github.com/kizzx2/e542fa74b80b7563045a) to implement a partial snap-to-grid:

- Start dragging a window, and press shift (briefly, it's modal). 
- A coloured overlay of the active zones on the top and what space the window will take will show.
- If you release the window "to the top active zone left" it will resize it to 4/16ths on the left, likewise on the right and if done in the middle area, to 8/16ths. 

https://user-images.githubusercontent.com/2410938/129484911-0719123e-34e5-4c49-ad1c-a536072b104f.mp4
