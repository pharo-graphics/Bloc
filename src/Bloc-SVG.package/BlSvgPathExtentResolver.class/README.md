I am used to calculate the extent of a BlSvgPath, thanks to my method 'computeExtentFor:'.

Here is how I proceed:
	- I take as an input for 'computeExtentFor:' a collection of commands, which is the 'pathData' instance variable of the BlSvgPath.
	- For each of these commands, I perform a method with the same name. These method take the extreme points of the segment drawn by the command and then checks if these points should alter my instance variables 'minPoint' and/or 'maxPoint'.
	- Once all the commands have been computed, I return the extent (which is 'maxPoint' minus 'minPoint').

Example of use:
	- BlSvgPathExtentResolver new computeExtentFor: aBlSvgPath pathData