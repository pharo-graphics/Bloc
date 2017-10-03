children accessing
allChildrenBreadthFirstDo: aBlock 
	self childrenDo: aBlock.
	self childrenDo: [ :each | each allChildrenBreadthFirstDo: aBlock ]