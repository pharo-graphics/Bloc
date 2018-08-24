"
I represent a homogeneous styled piece of text where every character has the same set of attributes.
I am data structure independent and rely only on BrText's public API
"
Class {
	#name : #BlSpan,
	#superclass : #BlWrappedText,
	#instVars : [
		'attributes'
	],
	#category : 'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlSpan class >> text: aBrText attributes: theAttributes [
	^ self basicNew
		initialize;
		text: aBrText
		attributes: theAttributes;
		yourself
]

{ #category : #'span - accessing' }
BlSpan >> attributes [
	"Return a set of attributes applied on this span"
	<return: #Set of: #BrTextAttribute>

	^ attributes
]

{ #category : #accessing }
BlSpan >> attributes: arg1 [ 
	^ self shouldBeImplemented
]

{ #category : #accessing }
BlSpan >> attributes: arg1 from: arg2 to: arg3 [ 
	^ self shouldBeImplemented
]

{ #category : #accessing }
BlSpan >> delete: arg1 to: arg2 [ 
	^ self shouldBeImplemented
]

{ #category : #accessing }
BlSpan >> insertString: arg1 at: arg2 [ 
	^ self shouldBeImplemented
]

{ #category : #accessing }
BlSpan >> insertText: arg1 at: arg2 [ 
	^ self shouldBeImplemented
]

{ #category : #initialization }
BlSpan >> text: aBrText attributes: theAttributes [
	text := aBrText.
	attributes := theAttributes
]

{ #category : #accessing }
BlSpan >> unstyle [
	^ self shouldBeImplemented
]
