Extension { #name : #OSWindow }

{ #category : #'*Bloc-Deprecated' }
OSWindow >> windowExtent [

	self
		deprecated: 'Use regular API'
		transformWith: '`@receiver windowExtent'
				-> '`@receiver extent'.

	^ self extent
]

{ #category : #'*Bloc-Deprecated' }
OSWindow >> windowExtent: aPoint [

	self
		deprecated: 'Use regular API'
		transformWith: '`@receiver windowExtent: `@statements1'
				-> '`@receiver extent: `@statements1'.

	self extent: aPoint
]
