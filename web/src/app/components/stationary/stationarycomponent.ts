import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionFactor } from '../emissionfactor/emissionfactor';
import { EmissionFactorService } from '../emissionfactor/emissionfactorservice';
import { Stationary } from './stationary';
import { StationaryService } from './stationaryservice';

@Component({
    templateUrl: './stationary.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class StationaryComponent implements OnInit {

    stationaryDialog: boolean;

    deleteStationaryDialog: boolean = false;

    stationaries: Stationary[];

    emissionFactors: EmissionFactor[];

    stationary: Stationary;

    submitted: boolean;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private stationaryService: StationaryService, 
                private emissionFactorService: EmissionFactorService, 
                private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.listEmissionFactors();
        this.list();

        this.cols = [
            {field: 'facilityId', header: 'Facility ID'},
            {field: 'year', header: 'Year'},
            {field: 'fuelName', header: 'Fuel'},
            {field: 'amount', header: 'Amount'},
            {field: 'co2', header: 'CO2'},
            {field: 'ch4', header: 'CH4'},
            {field: 'n2o', header: 'N2O'}
        ];

    }

    list() {
        this.stationaryService.list().subscribe(
            response => {
                this.stationaries = response
            }
        );
    }

    listEmissionFactors() {
        this.emissionFactorService.list().subscribe(
            response => {
                this.emissionFactors = response
            }
        );
    }

    openNew() {
        this.stationary = new Stationary();
        this.submitted = false;
        this.stationaryDialog = true;
    }

    editStationary(stationary: Stationary) {
        this.stationary = stationary;
        this.stationaryDialog = true;
    }

    deleteStationary(stationary: Stationary) {
        this.deleteStationaryDialog = true;
        this.stationary = {...stationary};
    }

    confirmDelete(){
        
        this.stationaryService.delete(this.stationary.stationaryCombustionId).subscribe(
            () => {
                this.stationary = new Stationary()
                this.deleteStationaryDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Stationary Combustion Deleted', life: 3000});
                this.stationary = new Stationary();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.stationaryDialog = false;
        this.submitted = false;
    }

    saveStationary() {
        this.submitted = true;

        this.stationaryService.save(this.stationary).subscribe(
            response => {
                this.stationary = response
                this.stationaryDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Stationary Combustion saved', life: 3000});
                this.list()
            }
        );

    }

    
}
