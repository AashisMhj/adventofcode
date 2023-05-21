const fs = require('fs');
const readline = require('readline');

let start = {
    x: 1, y: 1
};
let head = {
    x: 1, y: 1
};
let tail = {
    x: 1, y: 1
}
const tail_tiles = new Set();
tail_tiles.add('1-1')

function checkIsTouching(){
    const touching_tiles = [
        `${head.x - 1}-${head.y+1}`, `${head.x}-${head.y+1}`, `${head.x +1}-${head.y+1}`,
        `${head.x - 1}-${head.y}`, `${head.x}-${head.y}`, `${head.x +1}-${head.y}`,
        `${head.x - 1}-${head.y-1}`, `${head.x}-${head.y-1}`, `${head.x +1}-${head.y-1}`,
    ]
    const tail_location = `${tail.x}-${tail.y}`;
    return touching_tiles.includes(tail_location)
}

// get relation between head and tail 
function getStartingRef(){
    let x = '';
    let y = '';
    if(head.x < tail.x){
        x = 'l'
    }else if(head.x === tail.x){
        x = 'm';
    }else{
        x = 'r'
    }

    if(head.y > tail.y){
        y = 'u'
    }else if(head.y === tail.y){
        y = 'm'
    }else{
        y = 'b'
    }
    return `${x}-${y}`
}

const rl = readline.createInterface({
    input: fs.createReadStream('./input.txt'),
    output: process.stdout,
    terminal: false
});


rl.on('line', (line)=>{
    let [location, move] = line.split(" ");
    let no_move = parseInt(move);
    if(location === "R"){
        for(let i = 0; i < no_move; i++){
            const prvious_head_locaiton = {...head}
            head.x = head.x + 1;
            if(!checkIsTouching()){
                tail = prvious_head_locaiton;
                tail_tiles.add(`${tail.x}-${tail.y}`);
            }
        }
        // head.x += no_move 
    }else if(location === "U"){
        for(let i = 0; i <no_move; i++){
            const prvious_head_locaiton = {...head}
            head.y++
            if(!checkIsTouching()){
                tail = prvious_head_locaiton;
                tail_tiles.add(`${tail.x}-${tail.y}`);
            }
        }
    }else if(location === "L"){
        for(let i = 0; i < no_move; i++){
            const prvious_head_locaiton = {...head}
            head.x--
            if(!checkIsTouching()){
                tail = prvious_head_locaiton;
                tail_tiles.add(`${tail.x}-${tail.y}`);
            }
        }
    }else if(location === "D"){
        for(let i = 0; i < no_move; i++){
            const prvious_head_locaiton = {...head}
            head.y--
            if(!checkIsTouching()){
                tail = prvious_head_locaiton;
                tail_tiles.add(`${tail.x}-${tail.y}`);
            }
        }
    }

});

rl.on('close', ()=>{
    console.log(tail_tiles.size)
})