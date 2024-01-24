Extension { #name : #TBlLayoutParentNode }

{ #category : #'*Bloc-Deprecated' }
TBlLayoutParentNode >> layoutExtent [
	self
		deprecated: 'Use #extent instead.'
		transformWith: '`@receiver layoutExtent' -> '`@receiver extent'.

	^ self extent
]

{ #category : #'*Bloc-Deprecated' }
TBlLayoutParentNode >> measuredExtent [
	<return: #Point>

	self
		deprecated: 'Use #extent instead.'
		transformWith: '`@receiver measuredExtent' -> '`@receiver extent'.

	^ self extent
]

{ #category : #'*Bloc-Deprecated' }
TBlLayoutParentNode >> measuredExtent: aPoint [
	self
		deprecated: 'Please use extent: instead.'
		transformWith:
			'`@receiver measuredExtent: `@statements1'
				-> '`@receiver extent: `@statements1'.

	self extent: aPoint
]
