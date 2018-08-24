Class {
	#name : #BlInfiniteLayoutStepFlags,
	#superclass : #BlInfiniteFlags,
	#classVars : [
		'Animations',
		'Layout',
		'Start'
	],
	#category : 'Bloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
BlInfiniteLayoutStepFlags class >> Animations [
	"This method was automatically generated"
	^ Animations value
]

{ #category : #'accessing - flags' }
BlInfiniteLayoutStepFlags class >> Layout [
	"This method was automatically generated"
	^ Layout value
]

{ #category : #'accessing - flags' }
BlInfiniteLayoutStepFlags class >> Start [
	"This method was automatically generated"
	^ Start value
]

{ #category : #'flags declaration' }
BlInfiniteLayoutStepFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#START -> 1.
		#LAYOUT -> (1 << 1).
		#ANIMATIONS -> (1 << 2).
	}
]

{ #category : #initialization }
BlInfiniteLayoutStepFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
BlInfiniteLayoutStepFlags >> addAnimations [
	"This method was automatically generated"
	value := value | Animations value
]

{ #category : #'flags - add' }
BlInfiniteLayoutStepFlags >> addLayout [
	"This method was automatically generated"
	value := value | Layout value
]

{ #category : #'flags - add' }
BlInfiniteLayoutStepFlags >> addStart [
	"This method was automatically generated"
	value := value | Start value
]

{ #category : #'flags - clear' }
BlInfiniteLayoutStepFlags >> clearAnimations [
	"This method was automatically generated"
	value := value & (Animations value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteLayoutStepFlags >> clearLayout [
	"This method was automatically generated"
	value := value & (Layout value bitInvert)
]

{ #category : #'flags - clear' }
BlInfiniteLayoutStepFlags >> clearStart [
	"This method was automatically generated"
	value := value & (Start value bitInvert)
]

{ #category : #'flags - testing' }
BlInfiniteLayoutStepFlags >> hasAnimations [
	"This method was automatically generated"
	^ (value & Animations value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteLayoutStepFlags >> hasLayout [
	"This method was automatically generated"
	^ (value & Layout value) ~= 0
]

{ #category : #'flags - testing' }
BlInfiniteLayoutStepFlags >> hasStart [
	"This method was automatically generated"
	^ (value & Start value) ~= 0
]
