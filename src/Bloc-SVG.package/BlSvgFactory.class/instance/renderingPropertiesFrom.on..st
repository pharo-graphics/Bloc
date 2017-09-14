properties
renderingPropertiesFrom: attributes on: aBlElement
	self transformPropertiesFrom: attributes on: aBlElement.
	
	attributes at:'opacity' ifPresent: [ aBlElement opacity: (attributes at:'opacity') asNumber ].
	self fillPropertiesFrom: attributes on: aBlElement.
	self strokePropertiesFrom: attributes on: aBlElement.