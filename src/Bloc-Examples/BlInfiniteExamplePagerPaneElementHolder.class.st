Class {
	#name : #BlInfiniteExamplePagerPaneElementHolder,
	#superclass : #BlInfiniteHolder,
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteExamplePagerPaneElementHolder >> initialize [
	super initialize.
	
	itemElement := BlElement new.
	itemElement layout: BlLinearLayout vertical.
	itemElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
BlInfiniteExamplePagerPaneElementHolder >> pane: aPagerPane [
	| titleElement titleText |

	titleText := aPagerPane title asRopedText fontSize: 30.
	titleElement := BlTextElement new.
	titleElement text: titleText.
	titleElement padding: (BlInsets all: 10).
	
	itemElement addChild: titleElement.
	itemElement addChild: aPagerPane paneElement
]
