arithmetic
* aQuaternion
	"Multiply me by a given quaternion and return a new instance representing a multiplication result"
	| rX rY rZ rW |	"components of a resulting quaternion"
	<return: #BlQuaternion>

	rX := (x * aQuaternion w) + (w * aQuaternion x) + (y * aQuaternion z) - (z * aQuaternion y).
	rY := (y * aQuaternion w) + (w * aQuaternion y) + (z * aQuaternion x) - (x * aQuaternion z).
	rZ := (z * aQuaternion w) + (w * aQuaternion z) + (x * aQuaternion y) - (y * aQuaternion x).
	rW := (w * aQuaternion w) - (x * aQuaternion x) + (y * aQuaternion y) - (z * aQuaternion z).

	^ self class x: rX y: rY z: rZ w: rW