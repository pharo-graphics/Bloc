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
BlStartupShutdownTest >> testOnSessionChanged [

	| aSpace |
	aSpace := self newTestingSpace.
	aSpace onSessionChanged.
	self assert: aSpace isOpened
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

	host shutDown: false.
	host startUp: true.	

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
	
	host shutDown: false.
	host startUp: true.	

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
	
	host shutDown: false.
	aSpace hostSpace invalidate.
	
	host startUp: true.	

	self assert: aSpace isVisible
]
