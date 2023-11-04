Trait {
	#name : 'TBlElementCommonStyles',
	#category : 'Bloc-Basic-Style',
	#package : 'Bloc',
	#tag : 'Basic-Style'
}

{ #category : 'api - styles' }
TBlElementCommonStyles >> default [
	^ self styleFor: BlElementState default
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> default: aBlock [
	aBlock value: self default
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> deselected [
	^ self styleFor: BlElementState deselected
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> deselected: aBlock [
	aBlock value: self deselected
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> disabled [
	^ self styleFor: BlElementState disabled
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> disabled: aBlock [
	aBlock value: self disabled
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> enabled [
	^ self styleFor: BlElementState enabled
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> enabled: aBlock [
	aBlock value: self enabled
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> focused [
	^ self styleFor: BlElementState focused
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> focused: aBlock [
	aBlock value: self focused
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> hovered [
	^ self styleFor: BlElementState hovered
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> hovered: aBlock [
	aBlock value: self hovered
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> pressed [
	^ self styleFor: BlElementState pressed
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> pressed: aBlock [
	aBlock value: self pressed
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> selected [
	^ self styleFor: BlElementState selected
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> selected: aBlock [
	aBlock value: self selected
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> unfocused [
	^ self styleFor: BlElementState unfocused
]

{ #category : 'api - styles' }
TBlElementCommonStyles >> unfocused: aBlock [
	aBlock value: self unfocused
]
