scale
scale: aContentElement within: aScalableElement
	"Modify a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	
	^ (self strategy scale: aContentElement within: aScalableElement) min: self maxScale