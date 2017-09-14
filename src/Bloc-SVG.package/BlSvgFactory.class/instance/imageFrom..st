image
imageFrom: node
	|imageElement|
	imageElement := self rectFrom: node.
	
	node attributeAt:'xlink:href' ifPresent: [imageElement background: (BlImagePatternPaint form: (Form fromFileNamed: (node attributeAt:'xlink:href')) )].
	
	^imageElement