Class {
	#name : 'BlLinearLayoutExamples',
	#superclass : 'BlExamplesTest',
	#category : 'Bloc-Layout-Examples-LinearMigrated',
	#package : 'Bloc-Layout-Examples-LinearMigrated'
}

{ #category : 'instance creation' }
BlLinearLayoutExamples >> childElementMatchingParent [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : 'instance creation' }
BlLinearLayoutExamples >> childExact: aPoint [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : 'instance creation' }
BlLinearLayoutExamples >> childExactHeight: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : 'instance creation' }
BlLinearLayoutExamples >> childExactWidth: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : 'helpers' }
BlLinearLayoutExamples >> layoutInSpace: anElement [

	| space |
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: anElement.
	space show; waitPendingWork.
	space root removeChildren.
	space close; waitPendingWork
]

{ #category : 'instance creation' }
BlLinearLayoutExamples >> parentWithLinearHorizontalLayout [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		yourself
]

{ #category : 'instance creation' }
BlLinearLayoutExamples >> parentWithLinearVerticalLayout [
	^ BlElement new
		layout: BlLinearLayout vertical;
		yourself
]
