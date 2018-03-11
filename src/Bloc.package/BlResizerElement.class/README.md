I am an overlay that provides the mechanism of resizing a referenceElement. I have eight resizing elements for which the dragging logic are defined in the ==GtDiagrammerResizerListener== hierarchy.

Users might want to specify that I should ==preventMouseEvents== in order to still allow the user to interact with the ==referenceElement== even when I am active.