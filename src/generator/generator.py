"""Input expected by generator.py
S -> Name of problem instance

L1p L2p Tp -> Person's initial location, Person's target location, Person's initial time

N M -> Number of buses, Number of connections

<Next N lines>
B L1b Tb -> Bus Number, start location, bus start time

<Next M lines>
B L1c L2c W -> bus id , start location, final location, total time spent to go from location 1 to location 2
"""


template = """(define (problem {problem_name}) (:domain joao-and-the-bus)
(:objects 
    {stops} - stop
    {buses} - bus
    p1 - person
)

(:init
    (= (total-cost) 0)

    (= (time-person) {time_person})
    (at p1 s{person_start_pos})

{definitions}
)

(:goal (and
    (at p1 s{person_end_pos})
    (forall (?b - bus)
        (not (in-bus ?b))
    )
))

(:metric minimize (total-cost))
)

"""


def main():
    import argparse
    
    parser = argparse.ArgumentParser(
        prog='Generator',
        description='Generates a valid instance to the joao-and-the-bus pddl domain'
    )
    parser.add_argument('-o', '--output', default=1,
                        help='Output filename that the instance will generate')
    args = parser.parse_args()
    with open(args.output, 'w') as f:
        f.write(generate_problem())


def generate_problem() -> str:
    problem_name = input()
    # start_location, end_location, start_time
    person = [*map(int, input().split())]
    bus_count, connections_count = map(int, input().split())

    buses = {}
    for _ in range(bus_count):
        # bus, start_location, start_time
        bus, *rest = map(int, input().split())
        buses[bus] = rest

    definitions = {}
    for _ in range(connections_count):
        # bus, location1, location2, weight
        bus, *rest = map(int, input().split())
        if not bus in definitions:
            definitions[bus] = []
        definitions[bus].append(rest)

    all_locations = {
        location
        for connections in definitions.values()
        for connection in connections
        for location in connection[:2]
    }

    return template.format(
        problem_name=problem_name,
        stops=' '.join(f's{loc}' for loc in all_locations),
        buses=' '.join(f'b{bus}' for bus in buses),
        time_person=person[-1],
        person_start_pos=person[0],
        person_end_pos=person[1],
        definitions='\n\n'.join(
            format_definitions(definitions, buses)
        )
    )


def format_definitions(definitions: dict, buses: dict) -> list[str]:
    ans = []
    indentation = ' ' * 4
    for bus, connections in sorted(definitions.items()):
        road_lengths = []
        conn = []
        for loc1, loc2, weight in connections:
            road_lengths.append(f'(= (road-length s{loc1} s{loc2} b{bus}) {weight})')
            conn.append(f'(connect s{loc1} s{loc2} b{bus})')

        ans.append('\n'.join(indentation + x for x in [
            *road_lengths, *conn,
            f'(= (time-bus b{bus}) {buses[bus][1]})',
            f'(at b{bus} s{buses[bus][0]})'
        ]))
    return ans


if __name__ == '__main__':
    main()
