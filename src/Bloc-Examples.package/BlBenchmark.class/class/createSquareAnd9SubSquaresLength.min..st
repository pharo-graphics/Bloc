nested bench
createSquareAnd9SubSquaresLength: aLength min: aMin
|theRoot pos|
theRoot := BlElement new
	background:(BlBackground fill: Color random);
	size: (aLength ) asPoint;
	addEventHandler: (BlOnMouseOverHandler do:[:e| e target background: Color random asBlBackground]).

(aLength <= aMin) ifTrue:[^ theRoot] .
pos := (aLength/3)+1.
theRoot addChildren:{
	((self  createSquareAnd9SubSquaresLength:( aLength/3) integerPart asInteger -3 min: aMin) position:1@1).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:pos@1).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:(pos*2)@1).
	
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:1@pos).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:pos@pos).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:(pos*2)@pos).
	
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3  min: aMin) position:1@(pos*2)).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3  min: aMin) position:pos@(pos*2)).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3  min: aMin) position:(pos*2)@(pos*2)).
	}.
	
^ theRoot