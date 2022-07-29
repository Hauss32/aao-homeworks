const React = require('react');

class Calculator extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            firstNum: '',
            secondNum: '',
            result: 0
        }

        this.setFirstNum = this.setFirstNum.bind(this);
        this.setSecondNum = this.setSecondNum.bind(this);
        this.setAddNumsResult = this.setAddNumsResult.bind(this);
        this.setSubtractNumsResult = this.setSubtractNumsResult.bind(this);
        this.setMultiplyNumsResult = this.setMultiplyNumsResult.bind(this);
        this.setDivideNumsResult = this.setDivideNumsResult.bind(this);
        this.clearInputs = this.clearInputs.bind(this);
    }

    render() {
        let { firstNum, secondNum, result } = this.state;
        return (
            <div>
                <h1>{ result }</h1>
                <div>
                    <input onChange={ this.setFirstNum } value={ firstNum }></input>
                    <input onChange={ this.setSecondNum } value={ secondNum }></input>
                    <button onClick={this.clearInputs}>Clear</button>
                </div>
                <div>
                    <button onClick={ this.setAddNumsResult }>+</button>
                    <button onClick={ this.setSubtractNumsResult }>-</button>
                    <button onClick={ this.setMultiplyNumsResult }>*</button>
                    <button onClick={ this.setDivideNumsResult }>/</button>
                </div>
            </div>
        )
    }

    setFirstNum(event) {
        const value = event.target.value;
        this.setState( { firstNum: value } );
    }

    setSecondNum(event) {
        const value = event.target.value;
        this.setState({ secondNum: value });
    }

    setAddNumsResult(event) {
        event.preventDefault();
        const num1 = parseFloat(this.state.firstNum);
        const num2 = parseFloat(this.state.secondNum);
        const result = num1 + num2;
        this.setState( { result: result } );
    }

    setSubtractNumsResult(event) {
        event.preventDefault();
        const num1 = parseFloat(this.state.firstNum);
        const num2 = parseFloat(this.state.secondNum);
        const result = num1 - num2;
        this.setState({ result: result });
    }

    setMultiplyNumsResult(event) {
        event.preventDefault();
        const num1 = parseFloat(this.state.firstNum);
        const num2 = parseFloat(this.state.secondNum);
        const result = num1 * num2;
        this.setState({ result: result });
    }

    setDivideNumsResult(event) {
        event.preventDefault();
        const num1 = parseFloat(this.state.firstNum);
        const num2 = parseFloat(this.state.secondNum);
        const result = num1 / num2;
        this.setState({ result: result });
    }

    clearInputs(event) {
        event.preventDefault();
        this.setState( {
            firstNum: '',
            secondNum: '',
            result: 0
        } );
    }
}

module.exports = Calculator;