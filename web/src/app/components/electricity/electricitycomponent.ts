import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionFactor } from '../emissionfactor/emissionfactor';
import { EmissionFactorService } from '../emissionfactor/emissionfactorservice';
import { Electricity } from './electricity';
import { ElectricityService } from './electricityservice';

@Component({
    templateUrl: './electricity.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class ElectricityComponent implements OnInit {

    electricityDialog: boolean;

    deleteElectricityDialog: boolean = false;

    electricities: Electricity[];

    emissionFactors: EmissionFactor[];

    electricity: Electricity;

    submitted: boolean;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private electricityService: ElectricityService, 
                private emissionFactorService: EmissionFactorService, 
                private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.listEmissionFactors();
        this.list();

        this.cols = [
            {field: 'facilityId', header: 'Facility ID'},
            {field: 'year', header: 'Year'},
            {field: 'energyName', header: 'Energy'},
            {field: 'amount', header: 'Amount'},
            {field: 'co2', header: 'CO2'},
            {field: 'ch4', header: 'CH4'},
            {field: 'n2o', header: 'N2O'}
        ];

    }

    list() {
        this.electricityService.list().subscribe(
            response => {
                this.electricities = response
            }
        );
    }

    listEmissionFactors() {
        // get electricity fuel only - 4
        this.emissionFactorService.listBySegment(4).subscribe(
            response => {
                this.emissionFactors = response
            }
        );
    }

    openNew() {
        this.electricity = new Electricity();
        this.submitted = false;
        this.electricityDialog = true;
    }

    editElectricity(electricity: Electricity) {
        this.electricity = electricity;
        this.electricityDialog = true;
    }

    deleteElectricity(electricity: Electricity) {
        this.deleteElectricityDialog = true;
        this.electricity = {...electricity};
    }

    onChangeFuel(event) {
        if (this.electricity.amount != null && this.electricity.energy != null) {
            this.calculateEmissions(this.electricity.energy, this.electricity.amount)
        }
    }

    calculateEmissions(fuelId: number, amount: number) {
        this.electricityService.calculate(fuelId, amount).subscribe(
            response => {
                this.electricity.co2 = response.co2;
                this.electricity.ch4 = response.ch4;
                this.electricity.n2o = response.n2o;
            }
        );
    }

    confirmDelete(){
        
        this.electricityService.delete(this.electricity.electricityId).subscribe(
            () => {
                this.electricity = new Electricity()
                this.deleteElectricityDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Electricity Deleted', life: 3000});
                this.electricity = new Electricity();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.electricityDialog = false;
        this.submitted = false;
    }

    saveElectricity() {
        this.submitted = true;

        this.electricityService.save(this.electricity).subscribe(
            response => {
                this.electricity = response
                this.electricityDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Electricity saved', life: 3000});
                this.list()
            }
        );

    }

    
}
