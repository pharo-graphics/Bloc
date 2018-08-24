Extension { #name : #Key }

{ #category : #'*Bloc' }
Key class >> a [
	^ self character: $A
]

{ #category : #'*Bloc' }
Key class >> arrowDown [
	<return: #Key>
	^ self value: 16rff99
]

{ #category : #'*Bloc' }
Key class >> arrowLeft [
	<return: #Key>
	^ self value: 16rff96
]

{ #category : #'*Bloc' }
Key class >> arrowRight [
	<return: #Key>
	^ self value: 16rff98
]

{ #category : #'*Bloc' }
Key class >> arrowUp [
	<return: #Key>
	^ self value: 16rff97
]

{ #category : #'*Bloc' }
Key class >> b [
	^ self character: $B
]

{ #category : #'*Bloc' }
Key class >> backspace [
	<return: #Key>

	^ self value: 16rff08
]

{ #category : #'*Bloc' }
Key class >> c [
	^ self character: $C
]

{ #category : #'*Bloc' }
Key class >> character: aCharacter [
	<return: #Key>

	^ KeyTable
		at: aCharacter asUnicode
		ifAbsent: [ self basicNew
			withValue: aCharacter asUnicode
			andName: self unknownKeyName ]
]

{ #category : #'*Bloc' }
Key class >> d [
	^ self character: $D
]

{ #category : #'*Bloc' }
Key class >> delete [
	<return: #Key>

	^ self value: 16rffff
]

{ #category : #'*Bloc' }
Key class >> e [
	^ self character: $E
]

{ #category : #'*Bloc' }
Key class >> equal [
	^ self character: $=
]

{ #category : #'*Bloc' }
Key class >> escape [
	<return: #Key>
	
	^ self value: 16rff1b
]

{ #category : #'*Bloc' }
Key class >> f [
	^ self character: $F
]

{ #category : #'*Bloc' }
Key class >> g [
	^ self character: $G
]

{ #category : #'*Bloc' }
Key class >> h [
	^ self character: $H
]

{ #category : #'*Bloc' }
Key class >> i [
	^ self character: $I
]

{ #category : #'*Bloc' }
Key class >> j [
	^ self character: $J
]

{ #category : #'*Bloc' }
Key class >> k [
	^ self character: $K
]

{ #category : #'*Bloc' }
Key >> keyValue [
	^ value
]

{ #category : #'*Bloc' }
Key class >> l [
	^ self character: $L
]

{ #category : #'*Bloc' }
Key class >> leftAlt [
	<return: #Key>
	
	^ self value: 16rffe9
]

{ #category : #'*Bloc' }
Key class >> leftControl [
	<return: #Key>
	
	^ self value: 16rffe3
]

{ #category : #'*Bloc' }
Key class >> leftMeta [
	<return: #Key>
	
	^ self value: 16rffe7
]

{ #category : #'*Bloc' }
Key class >> leftShift [
	<return: #Key>
	^ self value: 16rffe1
]

{ #category : #'*Bloc' }
Key class >> m [
	^ self character: $M
]

{ #category : #'*Bloc' }
Key class >> minus [
	^ self character: $-
]

{ #category : #'*Bloc' }
Key class >> n [
	^ self character: $N
]

{ #category : #'*Bloc' }
Key class >> o [
	^ self character: $O
]

{ #category : #'*Bloc' }
Key class >> p [
	^ self character: $P
]

{ #category : #'*Bloc' }
Key class >> q [
	^ self character: $Q
]

{ #category : #'*Bloc' }
Key class >> r [
	^ self character: $R
]

{ #category : #'*Bloc' }
Key class >> return [
	<return: #Key>

	^ self value: 65293
]

{ #category : #'*Bloc' }
Key class >> rightAlt [
	<return: #Key>
	
	^ self value: 16rffea
]

{ #category : #'*Bloc' }
Key class >> rightControl [
	<return: #Key>
	
	^ self value: 16rffe4
]

{ #category : #'*Bloc' }
Key class >> rightMeta [
	<return: #Key>
	
	^ self value: 16rffe8
]

{ #category : #'*Bloc' }
Key class >> rightShift [
	<return: #Key>
	^ self value: 16rffe2
]

{ #category : #'*Bloc' }
Key class >> s [
	^ self character: $S
]

{ #category : #'*Bloc' }
Key class >> t [
	^ self character: $T
]

{ #category : #'*Bloc' }
Key class >> tab [
	<return: #Key>
	^ self value: 16rff09
]

{ #category : #'*Bloc' }
Key class >> u [
	^ self character: $U
]

{ #category : #'*Bloc' }
Key class >> v [
	^ self character: $V
]

{ #category : #'*Bloc' }
Key class >> w [
	^ self character: $W
]

{ #category : #'*Bloc' }
Key class >> x [
	^ self character: $X
]

{ #category : #'*Bloc' }
Key class >> y [
	^ self character: $Y
]

{ #category : #'*Bloc' }
Key class >> z [
	^ self character: $Z
]
