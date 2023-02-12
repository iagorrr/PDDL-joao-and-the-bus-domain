; Simple instance.
(define (problem instance5) (:domain joao-and-the-bus)
(:objects 
    s1 s2 s3 s4 - stop
    b1 b2 - bus
    p1 - person
)

(:init
	(= (total-cost) 0)

	(= (time-person) 0)
    (at p1 s1)

	(= (road-length s1 s2 b1) 3)
	(= (road-length s2 s3 b1) 3)
	(= (road-length s3 s4 b1) 3)
	(= (road-length s4 s1 b1) 3)
    (connect s1 s2 b1)
    (connect s2 s3 b1)
    (connect s3 s4 b1)
    (connect s4 s1 b1)
	(= (time-bus b1) 0)
    (at b1 s1)

	(= (road-length s1 s2 b2) 3)
	(= (road-length s2 s3 b2) 3)
	(= (road-length s3 s4 b2) 3)
	(= (road-length s4 s1 b2) 3)
    (connect s1 s2 b2)
    (connect s2 s3 b2)
    (connect s3 s4 b2)
    (connect s4 s1 b2)
	(= (time-bus b2) 0)
    (at b2 s1)
)

(:goal (and
    (at p1 s4)
))

(:metric minimize (total-cost))
)
