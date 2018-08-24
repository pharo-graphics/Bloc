"
I am the BlGeometry used to represent a SVG Path, which allows to make complex drawings.

A SVG Path is obtained through successives commands, which each symbolizes a movement of the virtual pen drawing the path.
My instance variable'pathData' stores the list of commands used to obtain my final drawing.

To instanciate myself I use the BlSvgPathConverter class, which will allow me to set my 'pathData' instance variable.
To calculate my extent I use the BlSvgPathExtentResolver class, which calculates my extent when I set my 'pathData' instance variable.

Instance creation examples:
	- BlSvgPath fromStream: 'M100,200 C100,100 250,100 250,200 S400,300 400,200' 
"
Class {
	#name : #BlSvgPath,
	#superclass : #BlGeometry,
	#instVars : [
		'pathData'
	],
	#category : 'Bloc-SVG-Path'
}

{ #category : #'instance creation' }
BlSvgPath class >> build: aBlock [
	^ self new build: aBlock
]

{ #category : #'instance creation' }
BlSvgPath class >> fromStream: aStream [
	^ self new fromStream: aStream
]

{ #category : #'instance creation' }
BlSvgPath >> build: aBlock [
	| aPathbuilder |
	aPathbuilder := BlSvgPathBuilder new.
	aBlock value: aPathbuilder.
	self pathData: aPathbuilder convertedPathData
]

{ #category : #'instance creation' }
BlSvgPath >> buildPathOnSpartaCanvas: aCanvas [
	| newPathData pathBuilder|
	pathBuilder := aCanvas path.
	newPathData := self pathData"Within: aBounds".
	newPathData do: [ :each |  each executeOn: pathBuilder ].
	^ pathBuilder finish
]

{ #category : #'geometry testing' }
BlSvgPath >> containsPoint: aPoint within: aBounds [
	| scaleFactor translation |
	scaleFactor := aBounds extent / self extent.
	translation := aBounds origin - self position.
	^ self geometryBounds containsPoint: aPoint / scaleFactor - translation
]

{ #category : #'instance creation' }
BlSvgPath >> fromStream: aStream [
	self pathData: (BlSvgPathBuilder new stream: aStream readStream) convertedPathData
]

{ #category : #accessing }
BlSvgPath >> height [
	^  extent y
]

{ #category : #accessing }
BlSvgPath >> matchExtent: anExtent [
	extent := anExtent.
	"self pathData: (self pathDataWithin: self geometryBounds)"
]

{ #category : #accessing }
BlSvgPath >> pathData [
	^ pathData
]

{ #category : #accessing }
BlSvgPath >> pathData: aCollection [
	| r |
	pathData := aCollection.
	r := BlSvgPathExtentResolver new computeExtentFor: pathData.
	extent := r extent.
	position := r minPoint.
]

{ #category : #private }
BlSvgPath >> pathDataWithin: aBounds [
	| scaleFactor translation newPathData |
	scaleFactor := (self extent x isZero or: [ self extent y isZero ])
		ifTrue: [ 1.0 asPoint ]
		ifFalse: [ aBounds extent / self extent ].
	translation := aBounds origin - self position.
	newPathData := self pathData deepCopy.
	newPathData
		do: [ :cmd | 
			cmd second
				withIndexDo: [ :p :i | 
					p isPoint
						ifTrue: [ cmd second at: i put: ((p x * scaleFactor x) @ (p y * scaleFactor y) + translation) asFloatPoint ]
						ifFalse: [ | newP |
							newP := p.
							(cmd first beginsWith: 'h')
								ifTrue: [ newP := (newP * scaleFactor x + translation x) asFloat ]
								ifFalse: [ (cmd first beginsWith: 'v')
										ifTrue: [ newP := (newP * scaleFactor y + translation y) asFloat ] ].
							cmd second at: i put: newP ] ] ].
	^ newPathData
]

{ #category : #accessing }
BlSvgPath >> width [
	^  extent x
]
