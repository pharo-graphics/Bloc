Class {
	#name : #BlOvershootingScrollerExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Scrolling'
}

{ #category : #'examples - base animation' }
BlOvershootingScrollerExamples >> exampleDate [
	^ DateAndTime year: 2018 month: 3 day: 31
]

{ #category : #'examples - fling vertically' }
BlOvershootingScrollerExamples >> flingTwiceWithFlywheel [
	<gtExample>
	| aScroller |

	aScroller := self overshootingScroller.
	aScroller
		fling: 0@0
		velocity: 0@100.

	aScroller
		fling: 0@0
		velocity: 0@100.

	self assert: aScroller velocity equals: (0 @ 200) asBlocVector.

	^ aScroller
]

{ #category : #'examples - instance creation' }
BlOvershootingScrollerExamples >> overshootingScroller [
	<gtExample>
	| aScroller |
	
	aScroller := BlOvershootingScroller new.
	
	self assert: aScroller isFlywheel. 
	
	^ aScroller
]
