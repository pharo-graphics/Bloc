examples - compositor
compositorRendering
	<gtExample>
	| element canvas compositor |

	element := self elementWithElevatedChildren.
	element forceLayout.
	
	canvas := MozCanvas checker: element extent.
	compositor := BlCompositor on: element.
	compositor drawOnSpartaCanvas: canvas.
	
	^ canvas