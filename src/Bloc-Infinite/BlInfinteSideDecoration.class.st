Class {
	#name : 'BlInfinteSideDecoration',
	#superclass : 'BlInfiniteDecoration',
	#category : 'Bloc-Infinite-Core',
	#package : 'Bloc-Infinite',
	#tag : 'Core'
}

{ #category : 'geometry' }
BlInfinteSideDecoration >> gap [
	^ 0
]

{ #category : 'geometry' }
BlInfinteSideDecoration >> requiredWidth [
	^ self subclassResponsibility 
]
