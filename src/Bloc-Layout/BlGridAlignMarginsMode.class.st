Class {
	#name : 'BlGridAlignMarginsMode',
	#superclass : 'BlGridAlignmentMode',
	#category : 'Bloc-Layout-Grid-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Grid-Utilities'
}

{ #category : 'testing' }
BlGridAlignMarginsMode >> isAlignMargins [
	^ true
]

{ #category : 'computing margins' }
BlGridAlignMarginsMode >> marginOf: aChildElement in: aGridLayout isHorizontal: isHorizontal isLeading: isLeading [

	^ aGridLayout measurer marginOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading
]
