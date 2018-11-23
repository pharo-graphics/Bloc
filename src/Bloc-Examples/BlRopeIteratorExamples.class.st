"
I contain examples of rope iterators
"
Class {
	#name : #BlRopeIteratorExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Rope'
}

{ #category : #strings }
BlRopeIteratorExamples >> a [
	<gtExample>
	
	^ 'a'
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> aCrRope [
	<gtExample>

	^ BlCollectionRope collection: self a, self cr
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> aCrRopeIterator [
	<gtExample>

	^ self aCrRope iterator
]

{ #category : #'examples - a,cr' }
BlRopeIteratorExamples >> aCrRopeIteratorFirstNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self aCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self a.
	self assert: anIterator position equals: 1 + self a size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - a,cr' }
BlRopeIteratorExamples >> aCrRopeIteratorFirstNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: anIterator position equals: 3.
	self assert: start equals: 1.
	self assert: end equals: 1.
	self assert: endDelimited equals: 2.
	self assert: anIterator hasNext not. 
	
	^ anIterator
]

{ #category : #'examples - hasNext' }
BlRopeIteratorExamples >> aCrRopeIteratorHasNext [
	<gtExample>
	| anIterator | 
	anIterator := self aCrRopeIterator.
	
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - a,cr' }
BlRopeIteratorExamples >> aCrRopeIteratorSecondNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self aCrRopeIteratorFirstNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self a size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 2 + self a size.
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> aCrbCrcRope [
	<gtExample>

	^ BlCollectionRope collection: self a, self cr, self b, self cr, self c
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> aCrbCrcRopeIterator [
	<gtExample>

	^ self aCrbCrcRope iterator
]

{ #category : #'examples - a,cr,b,cr,c' }
BlRopeIteratorExamples >> aCrbCrcRopeIteratorFirstNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self aCrbCrcRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self a.
	self assert: anIterator position equals: 1 + self a size + 1. "last one since we skip new line symbol"
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - a,cr,b,cr,c' }
BlRopeIteratorExamples >> aCrbCrcRopeIteratorFirstNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrbCrcRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 1.
	self assert: end equals: 1.
	self assert: endDelimited equals: 2.
	self assert: anIterator hasNext. 
	
	^ anIterator
]

{ #category : #'examples - a,cr,b,cr,c' }
BlRopeIteratorExamples >> aCrbCrcRopeIteratorSecondNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self aCrbCrcRopeIteratorFirstNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self a size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self b.
	self assert: anIterator position equals: 2 + self a size + self b size + 1.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - a,cr,b,cr,c' }
BlRopeIteratorExamples >> aCrbCrcRopeIteratorSecondNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrbCrcRopeIteratorFirstNextLineIndices.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self a size.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 3.
	self assert: end equals: 3.
	self assert: endDelimited equals: 4.
	self assert: anIterator hasNext. 
	
	^ anIterator
]

{ #category : #'examples - a,cr,b,cr,c' }
BlRopeIteratorExamples >> aCrbCrcRopeIteratorThirdNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self aCrbCrcRopeIteratorSecondNextLine.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self a size + self b size.

	nextLine := anIterator nextLine.

	self assert: nextLine collection equals: self c.
	self assert: anIterator position equals: 3 + self a size + self b size + self c size.
	self assert: anIterator hasNext not.

	^ anIterator
]

{ #category : #'examples - a,cr,b,cr,c' }
BlRopeIteratorExamples >> aCrbCrcRopeIteratorThirdNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrbCrcRopeIteratorSecondNextLineIndices.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self a size + self b size.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 5.
	self assert: end equals: 5.
	self assert: endDelimited equals: 5.
	self assert: anIterator hasNext not. 

	^ anIterator
]

{ #category : #strings }
BlRopeIteratorExamples >> b [
	<gtExample>
	
	^ 'b'
]

{ #category : #strings }
BlRopeIteratorExamples >> c [
	<gtExample>
	
	^ 'c'
]

{ #category : #strings }
BlRopeIteratorExamples >> cr [
	<gtExample>
	
	^ String cr
]

{ #category : #strings }
BlRopeIteratorExamples >> empty [
	<gtExample>
	
	^ ''
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> emptyRope [
	<gtExample>

	^ BlCollectionRope collection: self empty
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> emptyRopeIterator [
	<gtExample>

	^ self emptyRope iterator
]

{ #category : #'examples - hasNext' }
BlRopeIteratorExamples >> emptyRopeIteratorHasNext [
	<gtExample>
	| anIterator |
	
	anIterator := self emptyRopeIterator.
	
	self assert: anIterator position isZero.
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #strings }
BlRopeIteratorExamples >> haba [
	<gtExample>
	
	^ 'Haba'
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrCrCrRope [
	<gtExample>

	^ BlCollectionRope collection: self haba, self cr, self cr, self cr
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrCrCrRopeIterator [
	<gtExample>

	^ self habaCrCrCrRope iterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorFirstNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 1 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorFirstNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self habaCrCrCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 1.
	self assert: end equals: 4.
	self assert: endDelimited equals: 5.
	self assert: anIterator hasNext. 
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorForthNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrCrRopeIteratorThirdNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 4 + self haba size.
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorSecondNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrCrRopeIteratorFirstNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 2 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorSecondNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self habaCrCrCrRopeIteratorFirstNextLineIndices.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self haba size.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 5.
	self assert: end equals: 5.
	self assert: endDelimited equals: 6.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorThirdNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrCrRopeIteratorSecondNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 3 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,cr' }
BlRopeIteratorExamples >> habaCrCrCrRopeIteratorThirdNextLineIndices [
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self habaCrCrCrRopeIteratorSecondNextLineIndices.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self haba size.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 6.
	self assert: end equals: 6.
	self assert: endDelimited equals: 7.
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrCrHabaRope [
	<gtExample>

	^ BlCollectionRope collection: self haba, self cr, self cr, self haba
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrCrHabaRopeIterator [
	<gtExample>

	^ self habaCrCrHabaRope iterator
]

{ #category : #'examples - haba,cr,cr,haba' }
BlRopeIteratorExamples >> habaCrCrHabaRopeIteratorFirstNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrHabaRopeIterator.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 1 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,haba' }
BlRopeIteratorExamples >> habaCrCrHabaRopeIteratorSecondNextLine [
	<gtExample>
	| nextLine anIterator |

	anIterator := self habaCrCrHabaRopeIteratorFirstNextLine.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 3 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,cr,haba' }
BlRopeIteratorExamples >> habaCrCrHabaRopeIteratorThirdNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrHabaRopeIteratorSecondNextLine.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 3 + (self haba size * 2).
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrHabaCrHabaRope [
	<gtExample>

	^ BlCollectionRope collection: self haba, self cr, self haba, self cr, self haba
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrHabaCrHabaRopeIterator [
	<gtExample>

	^ self habaCrHabaCrHabaRope iterator
]

{ #category : #'examples - haba,cr,haba,cr,haba' }
BlRopeIteratorExamples >> habaCrHabaCrHabaRopeIteratorFirstNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrHabaCrHabaRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.

	self assert: nextLine collection equals: self haba.
	"we skipped one Cr"
	self assert: anIterator position equals: 2 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,haba,cr,haba' }
BlRopeIteratorExamples >> habaCrHabaCrHabaRopeIteratorSecondNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrHabaCrHabaRopeIteratorFirstNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 3 + (self haba size * 2).
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr,haba,cr,haba' }
BlRopeIteratorExamples >> habaCrHabaCrHabaRopeIteratorThirdNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrHabaCrHabaRopeIteratorSecondNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + (self haba size * 2).
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 3 + (self haba size * 3).
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrRope [
	<gtExample>

	^ BlCollectionRope collection: self haba, self cr
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaCrRopeIterator [
	<gtExample>

	^ self habaCrRope iterator
]

{ #category : #'examples - haba,cr' }
BlRopeIteratorExamples >> habaCrRopeIteratorFirstNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 1 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator
]

{ #category : #'examples - haba,cr' }
BlRopeIteratorExamples >> habaCrRopeIteratorSecondNextLine [
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrRopeIteratorFirstNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 2 + self haba size.
	self assert: anIterator hasNext not.
	
	^ anIterator
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaRope [
	<gtExample>

	^ BlCollectionRope collection: self haba
]

{ #category : #'instance creation' }
BlRopeIteratorExamples >> habaRopeEmptyIterator [
	<gtExample>

	^ self habaRope iterator: 0 to: 0
]

{ #category : #'examples - hasNext' }
BlRopeIteratorExamples >> habaRopeEmptyIteratorHasNext [
	<gtExample>
	| anIterator |

	anIterator := self habaRopeEmptyIterator.

	self assert: anIterator position isZero.
	self assert: anIterator hasNext not.

	^ anIterator
]

{ #category : #'examples - next span' }
BlRopeIteratorExamples >> nextSpanFontColorOnA [
	<gtExample>
	| aRope anIterator aSpan |
	
	aRope := BlCollectionRope collection: 'A'.
	anIterator := aRope iterator.
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	
	self assert: aSpan == aRope.
	self assert: anIterator hasNext not.
	
	^ aSpan
]

{ #category : #'examples - next span' }
BlRopeIteratorExamples >> nextSpanFontColorOnAWithColor [
	<gtExample>
	| aRope anIterator aSpan |

	aRope := (BlCollectionRope collection: 'A') attributes: { BlTextForegroundAttribute paint: Color red }.

	anIterator := aRope iterator.
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	
	self assert: aSpan == aRope.
	self assert: anIterator hasNext not.
	
	^ aSpan
]

{ #category : #'examples - next span' }
BlRopeIteratorExamples >> nextSpanFontColorOnHelloWorldWithColor [
	<gtExample>
	| aRope anIterator aSpan |

	aRope := (BlCollectionRope collection: 'Hello World').
	aRope := aRope attributes: { BlTextForegroundAttribute paint: Color red } from: 1 to: 5.
	aRope := aRope attributes: { BlTextForegroundAttribute paint: Color blue } from: 7 to: 11.

	anIterator := aRope iterator.
	
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan == aRope left left.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: 'Hello'.
	
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan == aRope left right.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: ' '.
	
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan == aRope right.
	self assert: anIterator hasNext not.
	self assert: aSpan asString equals: 'World'.

	^ aSpan
]
