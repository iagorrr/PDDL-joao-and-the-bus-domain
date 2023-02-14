"""Input expected by generator.py
S -> Name of problem instance

L1p L2p Tp -> Person's initial location, Person's target location, Person's initial time

<Next N lines representing the buses information>
B L1b Tb -> Bus Number, start location, bus start time
** ENDS AT -1

<Next M lines representing the connections information>
B L1c L2c W -> bus id , start location, final location, total time spent to go from location 1 to location 2
** ENDS AT -1
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
import os
import graphviz

def main():
    generate_problem()

def generate_problem() -> str:
    colors = ['black', 'red', 'blue', 'purple', 'yellow', 'fuchsia', 'crismon', 'aqua', 'orange', 'darkgreen', 'darkmagenta']

    problem_name = input()

    # start_location, end_location, start_time
    person = [*map(int, input().split())]

    buses = {}
    
    stops = set()
    graph = graphviz.Digraph(problem_name)

    # person start and end location.
    nodes = {person[0]: ['s'], person[1]: ['e']}
    
    while(True):
        bus, *rest = map(int, input().split())
        if bus == -1:
            break
        buses[bus] = rest

        if rest[0] not in nodes:
            nodes[rest[0]] = []
        nodes[rest[0]].append(f'b{bus}')

    for name, labels in nodes.items():
        graph.node(str(name), f'{name} {",".join(labels)}')
        stops.add(name)

    definitions = {}
    while(True):
        # bus, location1, location2, weight
        bus, *rest = map(int, input().split())

        if(bus == -1):
            break
        
        if not rest[0] in stops:
            graph.node(str(rest[0]), str(rest[0]))
            stops.add(rest[0])
        if not rest[1] in stops:
            graph.node(str(rest[1]), str(rest[1]))
            stops.add(rest[1])
        
        graph.edge(str(rest[0]), str(rest[1]), label=f'{bus}:{rest[2]}', weight=str(rest[2]), color=colors[bus])

        if not bus in definitions:
            definitions[bus] = []
        definitions[bus].append(rest)

    all_locations = {
        location
        for connections in definitions.values()
        for connection in connections
        for location in connection[:2]
    }
    
    problem_filename = os.path.join(os.path.dirname(__file__), '..', '..', 'instances', f'{problem_name}.pdf')
    graph.render(outfile=problem_filename)

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
