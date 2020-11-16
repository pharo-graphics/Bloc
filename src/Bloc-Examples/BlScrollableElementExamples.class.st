"
! Scrollable element

Scrollable element allows users to display a larger element in a smaller frame (so called ""window"") with the ability to scroll the content both veritcally and horizontally.

Let's start by creating a content element which in our case will be a list of all subclasses of ${class:SequenceableCollection}$. As you can see it is a quite tall element and it does not fit on a screen:
${example:BlScrollableElementExamples>>#scrollableContentInScalableElement|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded|noCode}$

Therefore we want to wrap such large element in a new instance of ${class:BlScrollableElement}$
${example:BlScrollableElementExamples>>#scrollableElement|previewShow=#gtLiveFor:|previewHeight=100}$

Once the ==scrollable== element is instantiated we can add our previously created content as a direct child to the scrollable element with ${method:BlElement>>#addChild:}$
${example:BlScrollableElementExamples>>#scrollableElementWithContent|previewShow=#gtLiveFor:|previewHeight=75|previewExpanded}$

We quickly notice that the ==scrollable== element does not have nice dimensions. We can fix it by asking the ==scrollable== element to match it's parent.
${example:BlScrollableElementExamples>>#scrollableMatchParent|previewShow=#gtLiveFor:|previewHeight=300|previewExpanded}$

While being the most common use case, match parent is not the only resizing strategy supported by a ==scrollable element==. Together with ==maxHeight:== constraint a scrollable element can be used with ==fit content==, which means that a scrollable element will grow in size to accommodate the scrolled element until reaching the limit set using `maxHeight:` or `maxWidth:`
${example:BlScrollableElementExamples>>#scrollableFitContentWithMaxHeight|previewShow=#gtLiveFor:|previewHeight=400|previewExpanded}$
"
Class {
	#name : #BlScrollableElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Scrolling'
}

{ #category : #'examples - setup' }
BlScrollableElementExamples >> data [
	^ #(#Alien #Array #ArrayedCollection #Bitmap #BlLayoutNodeChildren #BlTelemetryTasks #BlWeakRef #ByteArray #ByteString #ByteSymbol #CairoGlyphsArray #ColorArray #CompiledBlock #CompiledCode #CompiledMethod #Cubic #DoubleByteArray #DoubleWordArray #ExternalAddress #FFIArray #FFICallbackReturnValue #FFICallbackThunk #FFIExternalArray #FFITypeArray #FloatArray #FreeTypeCacheLinkedList #GLMMultiValue #IntegerArray #Interval #LGitExternalArray #LGitExternalCommitArray #LGitExternalStringArray #LGitExternalUInt8Array #LinkedList #MetacelloMethodSectionPath #MyCompiledMethodForTesting #OCLiteralList #ObjectFinalizerCollection #OrderedCollection #PointArray #ProcessList #RunArray #Semaphore #ShortIntegerArray #SocketAddress #SortedCollection #SparseLargeArray #SparseLargeTable #Stack #String #Symbol #Text #UUID #VMCallbackContext32 #VMCallbackContext64 #WeakActionSequence #WeakArray #WeakOrderedCollection #WideString #WideSymbol #WordArray #XMLStubOrderedListCustomCollection)
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableContent [
	<gtExample>
	| anElement |

	anElement := BlElement new.
	anElement layout: BlLinearLayout vertical.
	anElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	anElement addChildren:  (self data flatCollect: [ :eachClassName |
		{ BlTextElement new
			text: eachClassName asRopedText;
			padding: (BlInsets all: 15);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ].
		BlElement new
			background: (Color gray alpha: 0.2);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 1 ]	
		 } ]).
	^ anElement
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableContentInScalableElement [
	<gtExample>

	^ self scrollableContent asScalableElement
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableElement [
	<gtExample>

	^ BlScrollableElement new background: Color white.
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableElementWithContent [
	<gtExample>
	
	^ self scrollableElement addChild: self scrollableContent
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableExactHeight_01_default [
	<gtExample>
	| aScrollableElement |
	
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 200 ].
	
	aScrollableElement forceLayout.
	self assert: aScrollableElement extent equals: 300@200.
	self assert: aScrollableElement scrollPosition equals: 0@0.
	self assert: aScrollableElement scrolledElement position equals: 0@0.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableExactHeight_02_scrollToEnd [
	<gtExample>
	| aScrollableElement |
	
	aScrollableElement := self scrollableExactHeight_01_default.
	aScrollableElement scrollBy: 0@2903.

	aScrollableElement forceLayout.
	self assert: aScrollableElement scrolledElement height equals: 2903.0.
	self assert: aScrollableElement extent equals: (300 @ 200).
	self assert: aScrollableElement scrollPosition equals: 0@2703 negated.
	self assert: aScrollableElement scrolledElement position equals: 0@2703 negated.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableExactHeight_03_makeScrolledFixed [
	<gtExample>
	| aScrollableElement |
	
	aScrollableElement := self scrollableExactHeight_02_scrollToEnd.
	aScrollableElement scrolledElement height: 200.

	aScrollableElement forceLayout.
	self assert: aScrollableElement scrolledElement height equals: 200.0.
	self assert: aScrollableElement extent equals: (300 @ 200).
	self assert: aScrollableElement scrollPosition equals: 0@0.
	self assert: aScrollableElement scrolledElement position equals: 0@0.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableFitContent [
	<gtExample>
	| aScrollableElement |
	
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].

	aScrollableElement forceLayout.
	self assert: aScrollableElement scrolledElement height equals: 2903.0.
	self assert: aScrollableElement extent equals: (300 @ aScrollableElement scrolledElement height).

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableFitContentWithMaxHeight [
	<gtExample>
	| aScrollableElement |
	
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent.
		c maxHeight: 200 ].
	
	aScrollableElement forceLayout.
	self assert: aScrollableElement extent equals: 300@200.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableMatchParemtWithMaxHeight [
	<gtExample>
	| aScrollableElement |
	
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical matchParent.
		c maxHeight: 200 ].
	
	aScrollableElement forceLayout.
	self assert: aScrollableElement extent equals: 300@200.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableMatchParent [
	<gtExample>
	| aScrollableElement |

	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ aScrollableElement
]
