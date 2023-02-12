(define (problem instance8) (:domain joao-and-the-bus)
(:objects 
    s1 s2 s3 s4 s5 s6 s7 - stop
    b1 b2 - bus
    p1 - person
)

(:init
    (= (total-cost) 0)

    (= (time-person) 0)
    (at p1 s1)

    (= (road-length s1 s2 b1) 2)
    (= (road-length s2 s3 b1) 3)
    (= (road-length s3 s4 b1) 2)
    (= (road-length s4 s5 b1) 4)
    (= (road-length s5 s7 b1) 2)
    (= (road-length s7 s6 b1) 1)
    (= (road-length s6 s1 b1) 10)
    (connect s1 s2 b1)
    (connect s2 s3 b1)
    (connect s3 s4 b1)
    (connect s4 s5 b1)
    (connect s5 s7 b1)
    (connect s7 s6 b1)
    (connect s6 s1 b1)
    (= (time-bus b1) 0)
    (at b1 s1)

    (= (road-length s1 s6 b2) 10)
    (= (road-length s6 s5 b2) 2)
    (= (road-length s5 s6 b2) 1)
    (= (road-length s6 s1 b2) 10)
    (connect s1 s6 b2)
    (connect s6 s5 b2)
    (connect s5 s6 b2)
    (connect s6 s1 b2)
    (= (time-bus b2) 0)
    (at b2 s1)
)

(:goal (and
    (at p1 s6)
    (forall (?b - bus)
        (not (in-bus ?b))
    )
))

(:metric minimize (total-cost))
)

