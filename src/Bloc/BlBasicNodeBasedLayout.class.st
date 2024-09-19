Class {
	#name : #BlBasicNodeBasedLayout,
	#superclass : #BlNodeBasedLayout,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #layout }
BlBasicNodeBasedLayout >> layout: aParentNode [
	aParentNode childrenDo: [ :eachChildNode |
		eachChildNode position: eachChildNode constraints position ]
]

{ #category : #measure }
BlBasicNodeBasedLayout >> measure: aParentLayoutNode [

	self preMeasureChildrenNodes: aParentLayoutNode
]
