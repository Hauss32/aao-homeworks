// We are going to write a simple function that asks a user if they'd like tea and biscuits. 
// Chronologically, your function should:

// Ask the user if they'd like tea.
// console.log their response.
// Ask the user if they'd like biscuits.
// console.log their complete response: So you ${ firstAns } want tea and you ${ secondAns } want coffee.
// Close the reader.
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function promptTeaAndBuscuits() {
    rl.question('Would you like some tea? (`yes` or `no`)', (teaResp) => {
        let wantsTea;
        let wantsBiscuits;
        
        wantsTea = (teaResp === 'yes') ? 'do' : 'do not';
        console.log(`You ${wantsTea} want tea.`);
        
        rl.question('Would you like some buscuits? (`yes` or `no`)', (buscuitsResp) => {
            wantsBiscuits = (buscuitsResp === 'yes') ? 'do' : 'do not';
            console.log(`You ${wantsBiscuits} want buscuits.`);
            
            console.log(`So you ${wantsTea} want tea and ${wantsBiscuits} want buscuits. Got it!`);
            rl.close();
        });

    });
}

promptTeaAndBuscuits();