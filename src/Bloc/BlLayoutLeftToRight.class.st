"
I am a concrete left-to-right direction

"
Class {
	#name : 'BlLayoutLeftToRight',
	#superclass : 'BlLayoutDirection',
	#category : 'Bloc-Layouts-Support'
}

{ #category : 'testing' }
BlLayoutLeftToRight >> isLeftToRight [
	^ true
]

{ #category : 'testing' }
BlLayoutLeftToRight >> isRightToLeft [
	^ false
]

{ #category : 'dispatch' }
BlLayoutLeftToRight >> of: anObject [
	^ anObject leftToRight
]

{ #category : 'enumerating' }
BlLayoutLeftToRight >> with: aCollection do: aBlock [
	aCollection do: aBlock
]

{ #category : 'enumerating' }
BlLayoutLeftToRight >> with: aCollection inject: thisValue into: binaryBlock [
	^ aCollection inject: thisValue into: binaryBlock
]
