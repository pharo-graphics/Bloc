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
BlStartupShutdownTest >> testShutdownAndStartupKeepsSpacesInSamePosition [

	| aSpace |
	
	hostClass = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingOpenedSpaces.
	aSpace position: 100@100.
	aSpace extent: 200@200.

	self assert: aSpace position equals: 100@100.
	self assert: aSpace extent equals: 200@200.

	aSpace universe stopUniverse.
	aSpace universe startUniverse.	

	self assert: aSpace position equals: 100@100.
	self assert: aSpace extent equals: 200@200.
	
]

{ #category : #tests }
BlStartupShutdownTest >> testShutdownAndStartupKeepsSpacesOpen [

	| aSpace |

	hostClass = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].	

	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingOpenedSpaces.
	self assert: aSpace isVisible.
	
	aSpace universe stopUniverse.
	aSpace universe startUniverse.	

	self assert: aSpace isVisible.
	
]

{ #category : #tests }
BlStartupShutdownTest >> testShutdownAndStartupKeepsSpacesOpenWithInvalidation [

	| aSpace |
	
	hostClass = BlMorphicWindowHost ifTrue: [ ^ self skip ].
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingOpenedSpaces.
	self assert: aSpace isVisible.
	
	aSpace universe stopUniverse.
	aSpace hostSpace invalidate.
	
	aSpace universe startUniverse.	

	self assert: aSpace isVisible.
	
]
