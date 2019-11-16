### Download and try at your own risk. This is the latest source code for the project.

### Goto [latest state](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/tree/master/src/base/B777-300ER) <- [plugin code](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/tree/master/src/base/B777-300ER/plugins/SASLFree/data/modules/Custom%20Module) | [audio](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/tree/master/src/base/B777-300ER/plugins/SASLFree/data/modules/configuration/widgetResources) | [textures](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/tree/master/src/base/B777-300ER/objects)

### Install Guide (easy)
1. Download the repo [here](https://github.com/Chai112/Chai112-s-Boeing-777-300ER) as a ZIP file.\
![](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/blob/master/screenshots/tutorials/installer/1.png)
2. Run the installer in `Chai112-s-Boeing-777-300ER/installer/mac-installer` or `win-installer.exe`.\
**It is safely compiled using the source code right next to it `mac-installer.c` and `win-installer.c`.**\
**By downloading it, you accept the license it was written under. ([GNU](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/blob/master/License.txt))**\
![](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/blob/master/screenshots/tutorials/installer/2.png)
3. Drag and drop your [X-Plane directory](https://support.justflight.com/support/solutions/articles/17000066732-what-is-the-x-plane-root-folder-). It requires your X-Plane directory and will auto compile and install the aircraft for you in `Aircraft/Heavy Metal/B777-300ER` or XP11 equivilant.\
![](https://github.com/Chai112/Chai112-s-Boeing-777-300ER/blob/master/screenshots/tutorials/installer/3.png)

### Is it a virus?
This is a good way to prove that it isn't a virus. (it isn't a virus)
1. Inspect the source code `mac-installer.c` or `win-installer.c` to ensure no viruses (other people have done).
2. In terminal or command prompt, (make sure you select the correct path using `cd`) - ```gcc mac-installer.c -o mac-installer``` or ```gcc win-installer.c -o win-installer.exe``` which compiles the source code using [GNU's C Compiler (GCC)](https://gcc.gnu.org/). Basically, GCC (very commonly used and I have no control over) converts the source code `.c` into an executable which runs. This basically ensures that no extra code (aka virus) is added other than the source code (which you can inspect freely to ensure no malicious code is present).
3. Repeat Install Guide (easy) above with *your own* executable of the installer. If anything goes wrong in this step, make sure you have [MinGW](http://www.mingw.org/) installed or place enquiries at https://forums.x-plane.org/index.php?/profile/520176-chai112/.


### Install Guide (not easy) - Use Make to instantly update all changes to X-plane!
idk im making one
