nested bench
createSquareAnd4SubSquaresLength: aLength min: aMin
|theRoot pos|
theRoot := BlElement new
	background:(BlBackground fill: Color random);
	size: (aLength ) asPoint;
	addEventHandler: (BlOnMouseOverHandler do:[:e| e target background: Color random asBlBackground]).

(aLength <= aMin) ifTrue:[^ theRoot] .
pos := (aLength/2)+1.
theRoot addChildren:{
	((self  createSquareAnd4SubSquaresLength:( aLength/2) integerPart asInteger -2 min: aMin) position:1@1).
	((self  createSquareAnd4SubSquaresLength: ( aLength/2) integerPart asInteger -2 min: aMin) position:pos@1).
	((self  createSquareAnd4SubSquaresLength: ( aLength/2) integerPart asInteger -2 min: aMin) position:1@pos).
	((self  createSquareAnd4SubSquaresLength: ( aLength/2) integerPart asInteger -2 min: aMin) position:pos@pos).
	}.
	
^ theRoot