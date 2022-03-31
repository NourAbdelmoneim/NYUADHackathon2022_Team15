const express = require('express')
const app = express()
const fetch = require("node-fetch")

require('dotenv').config();

app.use(express.json())

const port = 3000

const api_key = process.env.API_KEY
const api_url = "https://maps.googleapis.com/maps/api/directions/json?"


/**
 * Gives the shortest possible time between point A and B 
 * @param {Point} pointA : {lat: value , lng: value}
 * @param {Point} pointB : {lat: value , lng: value}
 */

const getDistacne = async (pointA , pointB) => {
    try {
        const res = await fetch(`${api_url}origin=${pointA.lat},${pointA.lng}&destination=${pointB.lat},${pointB.lng}&key=${api_key}`)
        //console.log(`${api_url}origin=${pointA.lat},${pointA.lng}&destination=${pointB.lat},${pointB.lng}&key=${api_key}`)
        const jsonData = await res.json()
        
        return jsonData["routes"][0]["legs"][0]["duration"]["value"]
    } catch(e) {
        throw new Error(e)
    } 
}


/**
 * Intialize 2D array d * d 
 * @param {Number} d 
 * @returns 2D array
 */
function makeSquareArray(d) {
    var arr = new Array(d), i, l;
    for(i = 0, l = d; i < l; i++) {
        arr[i] = new Array(d);
    }
    return arr;
}

/**
 * Creates a complete graph with edges values equal to the distance between two points and stores it in a 2D array
 * @param {Point} location 
 * @param {Array of Points} points 
 * @returns AdhMatrix
 */
const graphData = async (location , points ) => {
    try {
        const allPoints = [location , ...points]
        const adjMatrix = makeSquareArray(allPoints.length )

        console.log(allPoints)
        for(let i =0 ;  i < allPoints.length ; i++) {
            for(let j =0 ; j < allPoints.length; j++) {
                if(i != j ) {
                    const d = await getDistacne(allPoints[i] , allPoints[j])
                    adjMatrix[i][j] = d 
                }
                else {
                    adjMatrix[i][j] = 0 
                }
            }
        }

        return adjMatrix
    }catch(e) {
        throw new Error(e)
    }
}

/**
 * This function outputs the best path for the traveler to travel in   
 */
app.get('/shortest-path', async (req, res) => {
    try {

        const location = req.body.location
        const points = req.body.points

        const graph = await graphData(location , points)
        console.log(graph)
        res.send("done")
    }catch(e) {
        console.log(e)
        res.status(500).send("Error has cocurred")
    }
})



app.listen(port, () => console.log(`Example app listening on port ${port}!`))