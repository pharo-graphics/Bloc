Extension { #name : 'BlStrokeLineMiterJoin' }

{ #category : '*Bloc-Alexandrie' }
BlStrokeLineMiterJoin >> aeApplyTo: aeCanvas style: aBorderStyle [

	aeCanvas setJoinMiter: aBorderStyle miterLimit
]
