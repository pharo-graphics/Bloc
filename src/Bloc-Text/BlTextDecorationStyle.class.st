"
# Text decoration style
Describes the style of the text {{gtClass:BlTextDecoration|label=decoration}} (like {{gtClass:BlTextDecorationDashedStyle|label=dashed}}, {{gtClass:BlTextDecorationDottedStyle|label=dotted}}, {{gtClass:BlTextDecorationDoubleStyle|label=double}}, {{gtClass:BlTextDecorationSolidStyle|label=solid}}, {{gtClass:BlTextDecorationWavyStyle|label=wavy}}).

"
Class {
	#name : 'BlTextDecorationStyle',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Text-Text-Decoration'
}

{ #category : 'cleanup' }
BlTextDecorationStyle class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlTextDecorationStyle class >> constructor [
	^ self subclassResponsibility
]

{ #category : 'api - instance creation' }
BlTextDecorationStyle class >> dashed [
	^ BlTextDecorationDashedStyle uniqueInstance
]

{ #category : 'api - instance creation' }
BlTextDecorationStyle class >> dotted [
	^ BlTextDecorationDottedStyle uniqueInstance
]

{ #category : 'api - instance creation' }
BlTextDecorationStyle class >> double [
	^ BlTextDecorationDoubleStyle uniqueInstance
]

{ #category : 'gt-extension' }
BlTextDecorationStyle class >> gtPreviewFor: aView [
	<gtView>
	
	self = BlTextDecorationStyle
		ifTrue: [ ^ aView empty ].
	
	^ aView forward
		title: 'Style preview';
		priority: 1;
		object: [ self new ];
		view: #gtPreviewFor:
]

{ #category : 'testing' }
BlTextDecorationStyle class >> isAbstract [
	^ self = BlTextDecorationStyle
]

{ #category : 'accessing' }
BlTextDecorationStyle class >> label [
	^ self subclassResponsibility
]

{ #category : 'api - instance creation' }
BlTextDecorationStyle class >> solid [
	^ BlTextDecorationSolidStyle uniqueInstance
]

{ #category : 'accessing' }
BlTextDecorationStyle class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'api - instance creation' }
BlTextDecorationStyle class >> wavy [
	^ BlTextDecorationWavyStyle uniqueInstance
]

{ #category : 'comparing' }
BlTextDecorationStyle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'gt-extension' }
BlTextDecorationStyle >> gtPreviewFor: aView [
	<gtView>

	self class isAbstract
		ifTrue: [ ^ aView empty ].
	
	^ aView text
		title: 'Preview';
		priority: 1;
		text: [
			self class label asRopedText
				fontSize: 20;
				decorationDo: [ :aTextDecorationAttribute | aTextDecorationAttribute underline decoration style: self ] ]
]

{ #category : 'comparing' }
BlTextDecorationStyle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : 'printing' }
BlTextDecorationStyle >> printOn: aStream [
	aStream nextPutAll: self class label
]

{ #category : 'printing' }
BlTextDecorationStyle >> storeOn: aStream [
	aStream
		nextPutAll: BlTextDecorationStyle name;
		space;
		nextPutAll: self class constructor
]
