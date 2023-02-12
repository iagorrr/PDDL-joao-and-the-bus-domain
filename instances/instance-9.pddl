(define (problem instance9) (:domain joao-and-the-bus)
(:objects 
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 - stop
    b1 b2 b3 - bus
    p1 - person
)

(:init
    (= (total-cost) 0)

    (= (time-person) 0)
    (at p1 s1)

    (= (road-length s1 s2 b1) 3)
    (= (road-length s2 s3 b1) 3)
    (= (road-length s3 s4 b1) 2)
    (= (road-length s4 s1 b1) 4)
    (connect s1 s2 b1)
    (connect s2 s3 b1)
    (connect s3 s4 b1)
    (connect s4 s1 b1)
    (= (time-bus b1) 0)
    (at b1 s1)

    (= (road-length s3 s5 b2) 4)
    (= (road-length s5 s6 b2) 2)
    (= (road-length s6 s7 b2) 1)
    (= (road-length s7 s8 b2) 2)
    (= (road-length s8 s3 b2) 6)
    (connect s3 s5 b2)
    (connect s5 s6 b2)
    (connect s6 s7 b2)
    (connect s7 s8 b2)
    (connect s8 s3 b2)
    (= (time-bus b2) 0)
    (at b2 s3)

    (= (road-length s3 s8 b3) 3)
    (= (road-length s8 s9 b3) 2)
    (= (road-length s9 s10 b3) 1)
    (= (road-length s10 s11 b3) 2)
    (= (road-length s11 s12 b3) 2)
    (= (road-length s12 s3 b3) 7)
    (connect s3 s8 b3)
    (connect s8 s9 b3)
    (connect s9 s10 b3)
    (connect s10 s11 b3)
    (connect s11 s12 b3)
    (connect s12 s3 b3)
    (= (time-bus b3) 0)
    (at b3 s11)
)

(:goal (and
    (at p1 s7)
    (forall (?b - bus)
        (not (in-bus ?b))
    )
))

(:metric minimize (total-cost))
)

