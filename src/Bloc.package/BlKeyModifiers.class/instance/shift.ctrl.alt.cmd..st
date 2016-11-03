initialization
shift: shiftBool ctrl: ctrlBool alt: altBool cmd: cmdBool
	hashKey := hashKey bitAt: 1 put: shiftBool asBit.
	hashKey := hashKey bitAt: 2 put: ctrlBool asBit.
	hashKey := hashKey bitAt: 3 put: altBool asBit.
	hashKey := hashKey bitAt: 4 put: cmdBool asBit