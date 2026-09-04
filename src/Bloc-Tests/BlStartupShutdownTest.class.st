Class {
	#name : #BlStartupShutdownTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #running }
BlStartupShutdownTest >> runCaseManaged [ 

	^ self runCase
]

{ #category : #tests }
BlStartupShutdownTest >> testHostRegistryShutdownAndStartupKeepsSpacesOpen [

	| aSpace |
	host class = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.
	aSpace show.
	aSpace settle.
	self assert: aSpace isVisible.

	BlHostRegistry shutDown: true.
	BlHostRegistry startUp: true.

	self assert: aSpace isVisible
]

{ #category : #tests }
BlStartupShutdownTest >> testShutdownAndStartupKeepsSpacesInSamePosition [

	| aSpace |
	
	host class = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	aSpace position: 100@100.
	aSpace extent: 200@200.

	self assert: aSpace position equals: 100@100.
	self assert: aSpace extent equals: 200@200.

	host universe stop.
	host universe start.	

	self assert: aSpace position equals: 100@100.
	self assert: aSpace extent equals: 200@200
]

{ #category : #tests }
BlStartupShutdownTest >> testShutdownAndStartupKeepsSpacesOpen [

	| aSpace |

	host class = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].	

	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	self assert: aSpace isVisible.
	
	host universe stop.
	host universe start.	

	self assert: aSpace isVisible
]

{ #category : #tests }
BlStartupShutdownTest >> testShutdownAndStartupKeepsSpacesOpenWithInvalidation [

	| aSpace |
	
	host class = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	self assert: aSpace isVisible.
	
	host universe stop.
	aSpace hostSpace invalidate.
	
	host universe start.	

	self assert: aSpace isVisible
]
