export class Transportation {
    
    transportationId: number;
    description: string;
    year: number;
    fuel: number;
    fuelName: string;
    amount: number;
    co2: number;
    ch4: number;
    n2o: number;

    constructor() {
        this.transportationId = null;
        this.description = null;
        this.year = null;
        this.fuelName = null;
        this.amount = null;
        this.co2 = null;
        this.ch4 = null;
        this.n2o = null;
    }
    
}