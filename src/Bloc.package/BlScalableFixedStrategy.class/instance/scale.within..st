scale
scale: aContentElement within: aScalableElement
	"Compute and return a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	
	^ self zoom