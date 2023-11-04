Class {
	#name : 'BlMousePickEvent',
	#superclass : 'BlMouseEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'converting' }
BlMousePickEvent >> asMouseOutsideEvent [

	^ self subclassResponsibility 
]

{ #category : 'processing' }
BlMousePickEvent >> findTargetFrom: aSpaceOrElement [

	^ (aSpaceOrElement findMousePickTargetFromEvent: self) ifNil: [ aSpaceOrElement space root ]
]
