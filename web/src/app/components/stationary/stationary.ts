export class Stationary {
    
    stationaryCombustionId: number;
    facilityId: string;
    year: number;
    fuel: number;
    fuelName: string;
    amount: number;
    co2: number;
    ch4: number;
    n2o: number;

    constructor() {
        this.stationaryCombustionId = null;
        this.facilityId = null;
        this.year = null;
        this.fuelName = null;
        this.amount = null;
        this.co2 = null;
        this.ch4 = null;
        this.n2o = null;
    }
    
}