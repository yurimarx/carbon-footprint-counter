export class EmissionFactor {
    
    emissionFactorId: number;
    name: string;
    emissionType: number;
    emissionTypeName: string;
    emissionName: string;
    hhv: number;
    co2Factor: number;
    ch4Factor: number;
    n2oFactor: number;
    biogenicCo2Factor: number;
    ar4: number;
    ar5: number;
    unit: number;
    source: string;
    fuelEfficiency: number;
    secondUnit: number;
    co4Kg: number;
    no2Kg: number;

    constructor() {
        this.emissionFactorId = null;
        this.name = null;
        this.emissionType = null;
        this.emissionTypeName = null;
        this.emissionName = null;
        this.hhv = null;
        this.co2Factor = null;
        this.ch4Factor = null;
        this.n2oFactor = null;
        this.biogenicCo2Factor = null;
        this.ar4 = null;
        this.ar5 = null;
        this.unit = null;
        this.source = null;
        this.fuelEfficiency = null;
        this.secondUnit = null;
        this.co4Kg = null;
        this.no2Kg = null;
    }
    
}