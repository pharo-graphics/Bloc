Class {
	#name : #BlInfiniteExamplePagerPaneElementHolder,
	#superclass : #BlInfiniteElementHolder,
	#category : 'Bloc-Infinite-Examples-Core - Pager'
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

	titleText := BrRopedText string: aPagerPane title.
	titleText attributes: {
		BrFontSizeAttribute size: 30
	}.
	titleElement := BlTextElement new.
	titleElement text: titleText.
	titleElement padding: (BlInsets all: 10).
	
	itemElement addChild: titleElement.
	itemElement addChild: aPagerPane paneElement
]
