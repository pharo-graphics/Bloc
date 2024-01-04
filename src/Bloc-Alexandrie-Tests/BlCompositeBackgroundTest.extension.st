Extension { #name : #BlCompositeBackgroundTest }

{ #category : #'*Bloc-Alexandrie-Tests' }
BlCompositeBackgroundTest >> testAeApplyTo [

	| space background blElement backgroundList |
	space := BlSpace new.
	
	backgroundList := OrderedCollection with: (BlBackground paint: Color blue).
	background := BlCompositeBackground withAll: backgroundList.
	blElement := BlElement new background: background; yourself.
	space root addChild: blElement.
	
	space aeAsForm. "check no errors"
]
