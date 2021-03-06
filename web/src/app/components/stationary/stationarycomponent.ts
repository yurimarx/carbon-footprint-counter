import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Subscription } from 'rxjs';
import { EmissionFactor } from '../emissionfactor/emissionfactor';
import { EmissionFactorService } from '../emissionfactor/emissionfactorservice';
import { FootprintTotals } from '../FootprintTotals';
import { Totals } from '../totals';
import { TotalsService } from '../totalsservice';
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

    totals: Totals;

    submitted: boolean;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    subscription: Subscription;

    constructor(private stationaryService: StationaryService, 
                private emissionFactorService: EmissionFactorService, 
                private messageService: MessageService,
                private totalsService: TotalsService,
                private footprintTotals: FootprintTotals,
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
        // get stationary fuel only - 1
        this.emissionFactorService.listBySegment(1).subscribe(
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

    onChangeFuel(event) {
        if (this.stationary.amount != null && this.stationary.fuel != null) {
            this.calculateEmissions(this.stationary.fuel, this.stationary.amount)
        }
    }

    calculateEmissions(fuelId: number, amount: number) {
        this.stationaryService.calculate(fuelId, amount).subscribe(
            response => {
                this.stationary.co2 = response.co2;
                this.stationary.ch4 = response.ch4;
                this.stationary.n2o = response.n2o;
            }
        );
    }

    confirmDelete(){
        
        this.stationaryService.delete(this.stationary.stationaryCombustionId).subscribe(
            () => {
                this.stationary = new Stationary()
                this.deleteStationaryDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Stationary Combustion Deleted', life: 3000});
                this.stationary = new Stationary();
                this.list()
                this.getTotals();
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
                this.stationary = response;
                this.stationaryDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Stationary Combustion saved', life: 3000});
                this.list();
                this.getTotals();
            }
        );

    }

    getTotals() {
        this.totalsService.getTotals().subscribe(
            response => {
                this.totals = response;
                this.footprintTotals.changeFootprintValues(
                    this.totals.co2 + '|' + this.totals.ch4 + '|' + this.totals.n2o);
            }
        );
    }

    
}
