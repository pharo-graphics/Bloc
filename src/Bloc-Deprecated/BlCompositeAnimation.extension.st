Extension { #name : #BlCompositeAnimation }

{ #category : #'*Bloc-Deprecated' }
BlCompositeAnimation class >> with: aCollectionOfAnimations [

	self 
		deprecated: 'Please use #withAll: instead' 
		transformWith: '`@receiver with: `@arg'
						  -> '`@receiver withAll: `@arg'.

	^ self new addAll: aCollectionOfAnimations
]
