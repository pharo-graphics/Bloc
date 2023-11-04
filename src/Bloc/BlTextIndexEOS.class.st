"
BlTextIndexEOS (End Of String) represents the index of the last character of a BlText.

Some collections used to store BlText may not always know their size, e.g. BlRopeableCollectionFile, which loads segments of the file for performance and memory management improvements.

BlTextIndexEOS looks enough like an Integer that it can be used in place of absolute references (Integers).

BlTextIndexEOS defers actual calculation of the index as long as possible, i.e. until some comparison is made (#<, #<=, #=, #>=, #>, #between:and:, etc.).  Arithmetic operations result in a new instance of BlTextEOS with the appropriate offset, see #+ and #-.


## Internal Representation and Key Implementation Points.

### Instance Variables

	approximateSize:		<Integer> The estimated size of the receiver's text until it is known.
	offset:					<Integer> An offset from the end of the string
	text:						<BlText> The indexed text.


### Implementation Points

"
Class {
	#name : 'BlTextIndexEOS',
	#superclass : 'BlTextIndex',
	#instVars : [
		'text',
		'offset',
		'approximateSize'
	],
	#package : 'Bloc',
	#tag : 'DataStructure - Rope'
}

{ #category : 'arithmetic' }
BlTextIndexEOS >> + aNumber [ 

	^ self class new 
		text: text;
		offset: offset + aNumber;
		yourself
]

{ #category : 'arithmetic' }
BlTextIndexEOS >> - aNumber [ 

	^ self class new 
		text: text;
		offset: offset - aNumber;
		yourself
]

{ #category : 'arithmetic' }
BlTextIndexEOS >> // aNumber [ 

	^ self index // aNumber
]

{ #category : 'arithmetic' }
BlTextIndexEOS >> \\ aNumber [ 

	^ self index \\ aNumber
]

{ #category : 'accessing' }
BlTextIndexEOS >> approximateSize [
	"Answer the receiver's text's approximate size.
	While the text size is not known, use an approximation, e.g. the file size.
	Once the text size is known, use the actual value.
	Cache the result since retrieving it is expensive (getting the file size requires system calls and hitting the disk)."

	^ self haveSize
		ifTrue: [ text approximateSize ]
		ifFalse: [ approximateSize ifNil: [ approximateSize := text approximateSize ] ]
]

{ #category : 'accessing' }
BlTextIndexEOS >> haveSize [

	^ text isNotNil and: [ text haveSize ]
]

{ #category : 'accessing' }
BlTextIndexEOS >> index [ 

	^ text
		ifNil: [ offset ]
		ifNotNil: [ self approximateSize + offset ]
]

{ #category : 'initialization' }
BlTextIndexEOS >> initialize [ 

	super initialize.
	offset := 0.
]

{ #category : 'accessing' }
BlTextIndexEOS >> offset [
	^ offset
]

{ #category : 'accessing' }
BlTextIndexEOS >> offset: anObject [
	offset := anObject
]

{ #category : 'printing' }
BlTextIndexEOS >> printOn: aStream [

	aStream
		<< 'EndOfString(';
		nextPut: (self haveSize ifTrue: [ $= ] ifFalse: [ $~ ]);
		print: self index;
		<< ')'
]

{ #category : 'accessing' }
BlTextIndexEOS >> text [
	^ text
]

{ #category : 'accessing' }
BlTextIndexEOS >> text: anObject [
	text := anObject
]
