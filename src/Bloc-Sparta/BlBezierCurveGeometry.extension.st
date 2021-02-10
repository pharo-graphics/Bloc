Extension { #name : #BlBezierCurveGeometry }

{ #category : #'*Bloc-Sparta' }
BlBezierCurveGeometry >> buildPathOnSpartaCanvas: aCanvas [
	self order = 0
		ifTrue: [ ^ aCanvas path build ].
	
	self order = 1
		ifTrue: [
			^ aCanvas path
				moveTo: self controlPoints first;
				build ].
			
	self order = 2
		ifTrue: [ ^ aCanvas shape line: self controlPoints first to: self controlPoints second ].
	
	self order = 3
		ifTrue: [ 
			^ aCanvas path
				moveTo: self controlPoints first;
				curveVia: self controlPoints second
					to: self controlPoints third;
				build ].
	
	self order = 4
		ifTrue: [ 
			^ aCanvas path
				moveTo: self controlPoints first;
				curveVia: self controlPoints second
					and: self controlPoints third
					to: self controlPoints fourth;
				build ].
	
	Error signal: 'Higher order Bezier Curves are not supported yet'
]
