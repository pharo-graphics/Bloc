api - attaching / detaching
attachTo: anElement
	super attachTo: anElement.

	resizerListeners do: [ :aResizerListener | aResizerListener resizeTarget: anElement ] 