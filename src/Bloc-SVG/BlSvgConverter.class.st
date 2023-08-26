"
I am used to convert a SVG file to a Bloc object.

Process:
    - I take a SVG File
    - Uses the XMLDOMParser to parse the file to get an XMLDocument and then take its root XMLElement
    - Uses my 'factory' instance variable to translate this XMLElement to a BlElement that I return

Example of uses that return a converted BlElement:
    - BlSVGConverter convertFromString: aString
    - BlSVGConverter convertFromFile: aFileName
    - BlSVGConverter convertFromURL: anUrl
"
Class {
	#name : #BlSvgConverter,
	#superclass : #Object,
	#instVars : [
		'factory'
	],
	#category : #'Bloc-SVG-Converter'
}

{ #category : #'instance creation' }
BlSvgConverter class >> convertFromFile: aFileName [
	| doc |
	doc := XMLDOMParser parseFileNamed: aFileName.
	^ self new convertXMLDocument: doc
]

{ #category : #'instance creation' }
BlSvgConverter class >> convertFromString: aString [
	| doc |
	doc := XMLDOMParser parse: aString.
	^ self new convertXMLDocument: doc
]

{ #category : #'instance creation' }
BlSvgConverter class >> convertFromURL: anUrl [
	| doc |
	doc := XMLDOMParser parse: anUrl asZnUrl retrieveContents asString.
	^ self new convertXMLDocument: doc
]

{ #category : #converting }
BlSvgConverter >> convertXMLDocument: doc [

	| root |
	root := doc nodes elements.
	(root size > 1 or: [ root first name ~= 'svg' ]) ifTrue: [
		self error: 'A root svg element expected' ].

	self factory reset.
	^ self factory svgFrom: root first
]

{ #category : #accessing }
BlSvgConverter >> factory [

	factory ifNil: [ factory := self factoryByDefault ].
	^ factory
]

{ #category : #accessing }
BlSvgConverter >> factory: anObject [

	factory := anObject
]

{ #category : #initialization }
BlSvgConverter >> factoryByDefault [

	^ BlSvgFactory new
]
