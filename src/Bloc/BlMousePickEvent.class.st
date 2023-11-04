Class {
	#name : #BlMousePickEvent,
	#superclass : #BlMouseEvent,
	#category : 'Bloc-Events'
}

{ #category : 'converting' }
BlMousePickEvent >> asMouseOutsideEvent [

	^ self subclassResponsibility 
]

{ #category : 'processing' }
BlMousePickEvent >> findTargetFrom: aSpaceOrElement [

	^ (aSpaceOrElement findMousePickTargetFromEvent: self) ifNil: [ aSpaceOrElement space root ]
]
