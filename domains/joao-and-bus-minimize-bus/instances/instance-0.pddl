(define (problem instance0) (:domain joao-and-the-bus)
(:objects 
    s1 s2 - stop
    b1 - bus
    p1 - person
)

(:init
	(= (total-cost) 0)

	(= (time-person) 0)
    (at p1 s1)

	(= (road-length s1 s2 b1) 10)
	(= (road-length s2 s1 b1) 10)
    (connect s1 s2 b1)
    (connect s2 s1 b1)
	(= (time-bus b1) 0)
    (at b1 s1)
)

(:goal (and
    (at p1 s2)
))

(:metric minimize (total-cost))
)

