Class {
	#name : #BlInfiniteLayoutStepFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'Final',
		'Layout',
		'Start'
	],
	#category : #'Bloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
BlInfiniteLayoutStepFlags class >> Final [
	"This method was automatically generated"
	^ Final value
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
		#START.
		#LAYOUT.
		#FINAL.
	}
]

{ #category : #'class initialization' }
BlInfiniteLayoutStepFlags class >> initialize [

	super initialize
]

{ #category : #'flags - add' }
BlInfiniteLayoutStepFlags >> addFinal [
	"This method was automatically generated"
	value := value | Final value
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
BlInfiniteLayoutStepFlags >> clearFinal [
	"This method was automatically generated"
	value := value & (Final value bitInvert)
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
BlInfiniteLayoutStepFlags >> hasFinal [
	"This method was automatically generated"
	^ (value & Final value) ~= 0
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
