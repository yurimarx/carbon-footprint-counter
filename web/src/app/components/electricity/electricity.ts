export class Electricity {
    
    electricityId: number;
    facilityId: string;
    year: number;
    energy: number;
    energyName: string;
    amount: number;
    co2: number;
    ch4: number;
    n2o: number;

    constructor() {
        this.electricityId = null;
        this.facilityId = null;
        this.year = null;
        this.energy = null;
        this.energyName = null;
        this.amount = null;
        this.co2 = null;
        this.ch4 = null;
        this.n2o = null;
    }
    
}