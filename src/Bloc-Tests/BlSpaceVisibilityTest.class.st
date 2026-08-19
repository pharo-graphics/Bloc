Class {
	#name : #BlSpaceVisibilityTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceVisibilityTest >> testHidingAnOpenSpaceHidesTheWindow [

	| aSpace |

	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	
	self assert: aSpace hostSpace isVisible.

	aSpace hide.	
	
	self deny: aSpace hostSpace isVisible
]

{ #category : #tests }
BlSpaceVisibilityTest >> testHidingAndShowingAnOpenSpaceShowsTheWindow [

	| aSpace |

	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	
	self assert: aSpace hostSpace isVisible.

	aSpace hide.	
	
	self deny: aSpace hostSpace isVisible.

	aSpace show.	
	aSpace settle.

	self assert: aSpace hostSpace isVisible
]
