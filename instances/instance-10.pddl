(define (problem instance-10) (:domain joao-and-the-bus)
(:objects 
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 - stop
    b1 b2 b3 b4 - bus
    p1 - person
)

(:init
    (= (total-cost) 0)

    (= (time-person) 0)
    (at p1 s1)

    (= (road-length s1 s2 b1) 2)
    (= (road-length s2 s3 b1) 2)
    (= (road-length s3 s4 b1) 2)
    (= (road-length s4 s1 b1) 1)
    (connect s1 s2 b1)
    (connect s2 s3 b1)
    (connect s3 s4 b1)
    (connect s4 s1 b1)
    (= (time-bus b1) 0)
    (at b1 s4)

    (= (road-length s15 s4 b2) 10)
    (= (road-length s4 s5 b2) 10)
    (= (road-length s5 s6 b2) 20)
    (= (road-length s6 s14 b2) 30)
    (= (road-length s14 s15 b2) 11)
    (connect s15 s4 b2)
    (connect s4 s5 b2)
    (connect s5 s6 b2)
    (connect s6 s14 b2)
    (connect s14 s15 b2)
    (= (time-bus b2) 0)
    (at b2 s8)

    (= (road-length s9 s10 b3) 2)
    (= (road-length s10 s5 b3) 2)
    (= (road-length s5 s6 b3) 2)
    (= (road-length s6 s7 b3) 2)
    (= (road-length s7 s8 b3) 2)
    (= (road-length s8 s9 b3) 2)
    (connect s9 s10 b3)
    (connect s10 s5 b3)
    (connect s5 s6 b3)
    (connect s6 s7 b3)
    (connect s7 s8 b3)
    (connect s8 s9 b3)
    (= (time-bus b3) 0)
    (at b3 s9)

    (= (road-length s11 s10 b4) 2)
    (= (road-length s10 s7 b4) 4)
    (= (road-length s7 s13 b4) 3)
    (= (road-length s13 s12 b4) 4)
    (= (road-length s12 s11 b4) 7)
    (connect s11 s10 b4)
    (connect s10 s7 b4)
    (connect s7 s13 b4)
    (connect s13 s12 b4)
    (connect s12 s11 b4)
    (= (time-bus b4) 0)
    (at b4 s11)
)

(:goal (and
    (at p1 s12)
    (forall (?b - bus)
        (not (in-bus ?b))
    )
))

(:metric minimize (total-cost))
)

