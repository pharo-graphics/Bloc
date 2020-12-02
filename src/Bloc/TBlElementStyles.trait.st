Trait {
	#name : #TBlElementStyles,
	#category : #'Bloc-Basic-Style'
}

{ #category : #'private - adding' }
TBlElementStyles >> basicAddStyle: aStyle [
	self explicitRequirement
]

{ #category : #'api - styles' }
TBlElementStyles >> default [
	^ self newOrExistingStyleForState: BlElementState default
]

{ #category : #'api - styles' }
TBlElementStyles >> deselected [
	^ self newOrExistingStyleForState: BlElementState deselected
]

{ #category : #'api - styles' }
TBlElementStyles >> disabled [
	^ self newOrExistingStyleForState: BlElementState disabled
]

{ #category : #'api - styles' }
TBlElementStyles >> enabled [
	^ self newOrExistingStyleForState: BlElementState enabled
]

{ #category : #'api - styles' }
TBlElementStyles >> focused [
	^ self newOrExistingStyleForState: BlElementState focused
]

{ #category : #'api - styles' }
TBlElementStyles >> hovered [
	^ self newOrExistingStyleForState: BlElementState hovered
]

{ #category : #'private - adding' }
TBlElementStyles >> newOrExistingStyleForState: aBlElementState [
	^ self
		styleForState: aBlElementState
		ifFound: [ :aStyle | aStyle ]
		ifNone: [
			| aNewStyle |
	
			aNewStyle := BlElementStyle new.
			aNewStyle state: aBlElementState.
			
			self basicAddStyle: aNewStyle.
			
			aNewStyle ]
]

{ #category : #'api - styles' }
TBlElementStyles >> pressed [
	^ self newOrExistingStyleForState: BlElementState pressed
]

{ #category : #'api - styles' }
TBlElementStyles >> selected [
	^ self newOrExistingStyleForState: BlElementState selected
]

{ #category : #'private - adding' }
TBlElementStyles >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	self explicitRequirement
]

{ #category : #'api - styles' }
TBlElementStyles >> unfocused [
	^ self newOrExistingStyleForState: BlElementState unfocused
]
