Extension { #name : #BlInfiniteElement }

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteElement >> aeDrawChildrenOn: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	super aeDrawChildrenOn: aCanvas.
	self itemDecorationsDo: [ :d | 
		d aeDrawOverOn: aCanvas in: self ]
]

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteElement >> aeDrawItemDecorationsOn: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	self itemDecorationsDo: [ :d | 
		d aeDrawBeneathOn: aCanvas in: self ].


]

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteElement >> aeDrawOn: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	super aeDrawOn: aCanvas.
	self aeDrawItemDecorationsOn: aCanvas


]
