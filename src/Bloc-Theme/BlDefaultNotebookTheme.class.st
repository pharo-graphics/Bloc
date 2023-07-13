Class {
	#name : #BlDefaultNotebookTheme,
	#superclass : #BlTheme,
	#instVars : [
		'deselectedPageTitleBackgroundColor',
		'selectedPageTitleBackgroundColor',
		'backgroundColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #accessing }
BlDefaultNotebookTheme >> backgroundColor [

	^ backgroundColor
]

{ #category : #accessing }
BlDefaultNotebookTheme >> backgroundColor: aColor [

	backgroundColor := aColor
]

{ #category : #accessing }
BlDefaultNotebookTheme >> deselectedPageTitleBackgroundColor [

	^ deselectedPageTitleBackgroundColor
]

{ #category : #accessing }
BlDefaultNotebookTheme >> deselectedPageTitleBackgroundColor: aColor [

	deselectedPageTitleBackgroundColor := aColor
]

{ #category : #initialization }
BlDefaultNotebookTheme >> initialize [

	super initialize.
	
	selectedPageTitleBackgroundColor := BlDefaultColors textHighlightColor.
	deselectedPageTitleBackgroundColor := BlDefaultColors defaultButtonBackgroundColor.
	backgroundColor := BlDefaultColors neutralBackgroundColor
]

{ #category : #accessing }
BlDefaultNotebookTheme >> selectedPageTitleBackgroundColor [

	^ selectedPageTitleBackgroundColor
]

{ #category : #accessing }
BlDefaultNotebookTheme >> selectedPageTitleBackgroundColor: aColor [

	selectedPageTitleBackgroundColor := aColor
]
