import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { Subscription } from 'rxjs';
import { EmissionFactor } from '../emissionfactor/emissionfactor';
import { EmissionFactorService } from '../emissionfactor/emissionfactorservice';
import { FootprintTotals } from '../FootprintTotals';
import { Totals } from '../totals';
import { TotalsService } from '../totalsservice';
import { Transportation } from './transportation';
import { TransportationService } from './transportationservice';

@Component({
    templateUrl: './transportation.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class TransportationComponent implements OnInit {

    transportationDialog: boolean;

    deleteTransportationDialog: boolean = false;

    transportations: Transportation[];

    emissionFactors: EmissionFactor[];

    transportation: Transportation;

    submitted: boolean;

    totals: Totals;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    subscription: Subscription;

    constructor(private transportationService: TransportationService, 
                private emissionFactorService: EmissionFactorService, 
                private totalsService: TotalsService,
                private footprintTotals: FootprintTotals,
                private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.listEmissionFactors();
        this.list();

        this.cols = [
            {field: 'year', header: 'Year'},
            {field: 'description', header: 'Description'},
            {field: 'fuelName', header: 'Fuel'},
            {field: 'amount', header: 'Amount'},
            {field: 'co2', header: 'CO2'},
            {field: 'ch4', header: 'CH4'},
            {field: 'n2o', header: 'N2O'}
        ];

    }

    list() {
        this.transportationService.list().subscribe(
            response => {
                this.transportations = response
            }
        );
    }

    listEmissionFactors() {
        // get transportation fuel only - 5
        this.emissionFactorService.listBySegment(5).subscribe(
            response => {
                this.emissionFactors = response
            }
        );
    }

    openNew() {
        this.transportation = new Transportation();
        this.submitted = false;
        this.transportationDialog = true;
    }

    editTransportation(transportation: Transportation) {
        this.transportation = transportation;
        this.transportationDialog = true;
    }

    deleteTransportation(transportation: Transportation) {
        this.deleteTransportationDialog = true;
        this.transportation = {...transportation};
    }

    onChangeFuel(event) {
        if (this.transportation.amount != null && this.transportation.fuel != null) {
            this.calculateEmissions(this.transportation.fuel, this.transportation.amount)
        }
    }

    calculateEmissions(fuelId: number, amount: number) {
        this.transportationService.calculate(fuelId, amount).subscribe(
            response => {
                this.transportation.co2 = response.co2;
                this.transportation.ch4 = response.ch4;
                this.transportation.n2o = response.n2o;
            }
        );
    }

    confirmDelete(){
        
        this.transportationService.delete(this.transportation.transportationId).subscribe(
            () => {
                this.transportation = new Transportation()
                this.deleteTransportationDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Transportation Deleted', life: 3000});
                this.transportation = new Transportation();
                this.list();
                this.getTotals();
            }
        );
    }

    hideDialog() {
        this.transportationDialog = false;
        this.submitted = false;
    }

    saveTransportation() {
        this.submitted = true;

        this.transportationService.save(this.transportation).subscribe(
            response => {
                this.transportation = response
                this.transportationDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Transportation saved', life: 3000});
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
