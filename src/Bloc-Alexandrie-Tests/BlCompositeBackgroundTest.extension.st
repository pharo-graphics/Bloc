Extension { #name : #BlCompositeBackgroundTest }

{ #category : #'*Bloc-Alexandrie-Tests' }
BlCompositeBackgroundTest >> testAeApplyTo [

	| space background blElement backgroundList |
	space := BlOSpace new.
	
	backgroundList := OrderedCollection with: (BlBackground paint: Color blue).
	background := BlCompositeBackground withAll: backgroundList.
	blElement := BlElement new background: background.
	space root addChild: blElement.
	
	space aeAsForm. "check no errors"
]
