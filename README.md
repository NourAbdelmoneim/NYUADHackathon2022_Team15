# Salem Teslam سلم تسلم

<p align="center"><img src="https://i.ibb.co/tbPGLJy/Group-2-1.png"></p>

Salem Teslam (سلم تسلم) is a mobile application that uses Quantum Computing and google maps API to calculate and output the shortest overall route for multiple deliveries, optimizing delivery time and order. 

## Link to Presentation

Please find the presentation [here](https://drive.google.com/file/d/15L1dQC_L6oQJXzFDT9DVX2MEw8Eqga34/view?usp=sharing).

## Problem Statement


Delivery driving accidents are the number one cause of death and disability in the UAE. 
Often times delivery drivers within the UAE are in a rush to deliver food to demanding customers and cram as many orders as possible within the day since they are getting paid by commission. This leads to countless accidents and increase in drivers' unemployment rates.

# SALEM TESLAM

Salem Tesslam solves issues of congestion, environmental solution, and , importantly, relieves the pressure of time constraint for delivery drivers looking to make multiple stops that can lead to severe vehicle accidents.  We implement Quantum Computing as a means of getting the fastest, most efficient routes in ways that classical computers couldn't complete within a reasonable amount of time to come up with a solution to the famous, NP-hard, travelling salesman problem.  The user can enter multiple points where they must reach for a dropoff of goods, and our algorithm takes into account all the factors necessary to make their ride quicker, thus discouraging them from weaving in and out of traffic just to get a job done quicker and make more money.  This app will prove to be a fantastic use of a new, innovative technology for social good.

We implemented two quantum algorithms which work on two separate industry quantum computers and use slightly different algorithms to give the user the option to decide between them and compare efficiency of the calculated route: The first uses Amazon Web Server's BraKet framework and solves the TSP using Quantum Annealing and Dwaves, while the second uses IBM's Qiskit framework and incorporates the VQE algorithm.

## AWS BraKet method

We used AWS BraKet to try to solve the TSP.  We first have a long list of import statements in our code which calls in all the necessary libraries to run a quantum computing algorithm in python.  We then have a function in the file **BraKet_tsp.py** that is called with a parameter **map_file**, which will be provided by another file which downloads the google maps API to be displayed on our frontend.  

From there, we load the map data into a pandas array and find the distances between selected dropoff points, and then multiple steps are taken to finalize setting up a graph which contains nodes representing the stopping points along the route and edges connecting all the stopping points for which direct travel between them is possible (i.e. if there are no obstacles that can't be surpassed without going through another designated stopping point) and assigning them weights.

From the completed graph data we are then able to formulate it into a QUBO (Quantum Unconstrained Binary Optimization) formula so that it can be in a format which is applicable to a Quantum Algorithm.

Once we have an actual optimization problem defined in the QUBO form we can convert it to an Ising Hamiltonian in order to make it applied to Quantum waves.

Lastly, we solve our optimization problem using Quantum Annealing and D-wave claculations to select the optimal route for the delvery person to travel.  A list of the optimal order of travel along with it's total distance required to complete the route is returned as the solution and written to a text file **braket_solution.txt**

## IBM Qiskit Solution

We used IBM's Qiskit and a VQE (Variational Quantum Eigensolver) to solve the TSP problem. This solution was tested on a simulator and was able to compute the optimal path withh 3 nodes in 5 seconds. 

Input: 
- input.txt file containing adjacency matrix (space seperated values) 

Ouput:
- output.txt file containing the optimal path

Example Input:
```
0 48 91
48 0 63
91 63 0
```

Example output:
```
1 2 0
```

## Running Instructions

```
AWS Braket
python3 braket_tsp.py

Qiskit
python3 qiskit.py 

```

## Solution

Mobile application for delivery drivers with the following features:
- Driver inputs locations he would like to travel to
- User interface shows a routed map with all the locations in optimal order and distance with estimated duration
- Each time the driver reaches one of the locations, it verifies that he has reached and removes that point from the route.

- The impact of this application is to reduce time taken for drivers to deliver orders and in turn reducing on road stress and hopefully reducing number of motorcycle accidents.



## Software Ingredients

Frontend: Flutter

-Used for the user interface which displays a map, takes in multiple locations as inputs and outputs the optimal route of onto the maps.

Backend: Node.js and Google Maps API

-Used to take in the google maps API and calculates the distance/duration between each pair of locations (nodes) and outputs this data in the form of an adjacency matrix

Quantum Computing Algorithms

-Takes in the number of locations inputted by user and uses them as nodes. The edges between the nodes have weights on them which are the durations between pairs of nodes from the backend.

-Solves Traveling Salesman Problem by transforming the problem into QUBO -> Ising Hamiltonian -> Variational Quantum Eigensolver or Quantum Annealing.

-Outputs optimal order of locations which takes the least time/distance in the form of an ordered array of the numbered nodes.


## Team Members

![Group Picture](assets/group_picture.jpg)

#### Hackers

- Abdallah Saleh
- Bhavicka Mohta
- Nour Abdelmoneim 
- Omar El Herraoui
- Omar Aburish
- Yousra Farhani


#### Mentors

- Shoaib Mohammed
- Mousa Farajallah
- David Morcuende
- Sama Kanbour

![Team Members](assets/team_members.png)
