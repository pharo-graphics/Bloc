"
I implement common helper methods used in layout tests.

Developers of layout tests may want to use instance creation methods I provide.
"
Trait {
	#name : #TBlLayoutTests,
	#category : 'Bloc-Layout-Tests-Utilities'
}

{ #category : #'instance creation' }
TBlLayoutTests >> exact: aPoint [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : #'instance creation' }
TBlLayoutTests >> exactHeight: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
TBlLayoutTests >> exactWidth: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
TBlLayoutTests >> matchParent [
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		yourself
]

{ #category : #'instance creation' }
TBlLayoutTests >> matchWidthFitHeight [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]
