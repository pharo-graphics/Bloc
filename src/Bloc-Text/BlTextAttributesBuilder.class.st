"
I represent a text properties - a collection of attributes. They can be added dynamically with the help of corresponding api methods.

```
BlTextAttributesBuilder new
	bold;
	italic;
	fontSize: 30;
	fontName: 'Roboto';
	foreground: Color darkGray
```

"
Class {
	#name : 'BlTextAttributesBuilder',
	#superclass : 'Object',
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'attributes'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Support',
	#package : 'Bloc-Text',
	#tag : 'Text-Support'
}

{ #category : 'hook' }
BlTextAttributesBuilder >> applyOn: aBlText [
	"Apply these text properties on a given text"

	^ aBlText attributes: self attributes
]

{ #category : 'accessing' }
BlTextAttributesBuilder >> attribute: aTextAttribute [
	| anExistingAttributeIndex |

	anExistingAttributeIndex := (self attributes
		detectIndex: [ :eachAttribute | eachAttribute type = aTextAttribute type ]
		ifNone: [ 0 ]).

	anExistingAttributeIndex isZero
		ifTrue: [ self attributes add: aTextAttribute ]
		ifFalse: [ self attributes at: anExistingAttributeIndex put: aTextAttribute ]
]

{ #category : 'accessing' }
BlTextAttributesBuilder >> attributes [
	<return: #Collection of: #BlTextAttribute>
	
	^ attributes
]

{ #category : 'hook' }
BlTextAttributesBuilder >> attributes: aCollectionOfAttributes [
	aCollectionOfAttributes do: [ :eachAttribute | self attribute: eachAttribute ]
]

{ #category : 'accessing' }
BlTextAttributesBuilder >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ self
]

{ #category : 'testing' }
BlTextAttributesBuilder >> hasAttribute: anAttribute [
	^ self attributes
		detect: [ :eachAttribute | eachAttribute type = anAttribute type ]
		ifFound: [ :eachAttribute | eachAttribute equals: anAttribute ]
		ifNone: [ false ]
]

{ #category : 'initialization' }
BlTextAttributesBuilder >> initialize [
	super initialize.
	
	attributes := OrderedCollection new
]
