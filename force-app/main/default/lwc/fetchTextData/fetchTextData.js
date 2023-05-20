import { LightningElement, track } from 'lwc';

export default class FetchTextData extends LightningElement {
    @track resultText = [{}];
    /*connectedCallback() {
        this.getCatFactText();
    }
    //resultText = 'Sample text';
    getCatFactText() {
        let endPoint = "https://catfact.ninja/fact";
        fetch(endPoint, {
            method: "GET"
        })
        .then((response) => response.json()) 
        .then((resultText) => {
            console.log('resultText: ', resultText);
            this.resultText = resultText;
        });
    }*/
    async getCatFactText() {
        let endPoint = "https://catfact.ninja/fact";
        const response = await fetch(endPoint);
        const result = await response.json();
        console.log(result);
        this.resultText = result;
        console.log(resultText);
    }
}