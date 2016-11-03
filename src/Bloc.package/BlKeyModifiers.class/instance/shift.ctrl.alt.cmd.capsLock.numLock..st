initialization
shift: shiftBool ctrl: ctrlBool alt: altBool cmd: cmdBool capsLock: capsLockBool numLock: numLockBool
	hashKey := hashKey bitAt: 1 put: shiftBool asBit.
	hashKey := hashKey bitAt: 2 put: ctrlBool asBit.
	hashKey := hashKey bitAt: 3 put: altBool asBit.
	hashKey := hashKey bitAt: 4 put: cmdBool asBit.
	hashKey := hashKey bitAt: 5 put: capsLockBool asBit.
	hashKey := hashKey bitAt: 6 put: numLockBool asBit