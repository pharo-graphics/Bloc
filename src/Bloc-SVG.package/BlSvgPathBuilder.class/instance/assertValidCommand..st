converting
assertValidCommand: aCharacter 

	( #( $M $m $Z $z $L $l $H $h $V $v $C $c $S $s $Q $q $T $t $A $a ) includes: aCharacter )
		ifFalse: [ self error: 'invalid path segment command' ]