measurement - computation
calculateChildMeasureSpec: aParentSize parentSpec: aParentSpec padding: aPadding childResizer: aChildResizer canScroll: canScroll
	"Calculate a MeasurementSpec for measuring a child element in one dimension"
	<return: #BlMeasurementSpec>
	| aSize |
	
	aSize := aParentSize - aPadding.
	
	aChildResizer isExact
		ifTrue: [ ^ BlMeasurementSpec exact: aChildResizer size ].	
	
	canScroll
		ifTrue: [
			aChildResizer isMatchParent
				ifTrue: [
					aParentSpec isAtMost
						ifTrue: [ ^ BlMeasurementSpec atMost: aSize ].
					aParentSpec isExact
						ifTrue: [ ^ BlMeasurementSpec exact: aSize ].
					aParentSpec isUnspecified
						ifTrue: [ ^ BlMeasurementSpec unspecified ] ]
				ifFalse: [
					aChildResizer isFitContent
						ifTrue: [ ^ BlMeasurementSpec unspecified ] ] ]
		ifFalse: [ 
			aChildResizer isMatchParent
				ifTrue: [ ^ BlMeasurementSpec size: aSize mode: aParentSpec mode ].
			aChildResizer isFitContent
				ifTrue: [ 
					(aParentSpec isAtMost or: [ aParentSpec isExact ])
						ifTrue: [ ^ BlMeasurementSpec atMost: aSize ]
						ifFalse: [ ^ BlMeasurementSpec unspecified ] ] ].
	
	^ BlMeasurementSpec unspecified