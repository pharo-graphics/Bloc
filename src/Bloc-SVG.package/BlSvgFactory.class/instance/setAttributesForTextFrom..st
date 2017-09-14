text
setAttributesForTextFrom: node
	"In svg the fill attribute from the text element commands the text color, not the background color.
	That's why Bloc should treat this attribute the same way it does the stroke attribute from the other svg elements."
	
	node attributes at:'fill' ifPresent:[ node attributeAt:'font-color' put: (node attributeAt:'fill').
		node removeAttribute: 'fill'].
	node attributes at:'fill-opacity' ifPresent: [ node attributeAt:'opacity' put: (node attributeAt:'fill-opacity').
		node removeAttribute: 'fill-opacity'].