Class {
	#name : #BlMousePickEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlMousePickEvent >> asMouseOutsideEvent [

	^ self subclassResponsibility 
]

{ #category : #processing }
BlMousePickEvent >> findTargetFrom: aSpaceOrElement [

	" The result can be nil in case of a consumed mousePickOutside event "
	^ aSpaceOrElement findMousePickTargetFromEvent: self
]
