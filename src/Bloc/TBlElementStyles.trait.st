Trait {
	#name : 'TBlElementStyles',
	#category : 'Bloc-Basic-Style',
	#package : 'Bloc',
	#tag : 'Basic-Style'
}

{ #category : 'private - adding' }
TBlElementStyles >> basicAddStyle: aStyle [

	self explicitRequirement
]

{ #category : 'private - adding' }
TBlElementStyles >> newStyleForState: aBlElementState [

	^ BlElementStyle new
		  state: aBlElementState;
		  yourself
]

{ #category : 'private - adding' }
TBlElementStyles >> styleFor: aBlElementState [

	^ self
		styleForState: aBlElementState
		ifFound: [ :aStyle | aStyle ]
		ifNone: [
			| aNewStyle |
			aNewStyle := self newStyleForState: aBlElementState.			
			self basicAddStyle: aNewStyle.
			aNewStyle ]
]

{ #category : 'private - adding' }
TBlElementStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [

	self explicitRequirement
]
