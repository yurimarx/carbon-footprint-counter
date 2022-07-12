import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionFactor } from '../emissionfactor/emissionfactor';
import { EmissionFactorService } from '../emissionfactor/emissionfactorservice';
import { Mobile } from './mobile';
import { MobileService } from './mobileservice';

@Component({
    templateUrl: './mobile.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class MobileComponent implements OnInit {

    mobileDialog: boolean;

    deleteMobileDialog: boolean = false;

    mobiles: Mobile[];

    emissionFactors: EmissionFactor[];

    mobile: Mobile;

    submitted: boolean;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private mobileService: MobileService, 
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
        this.mobileService.list().subscribe(
            response => {
                this.mobiles = response
            }
        );
    }

    listEmissionFactors() {
        // get mobile fuel only - 2
        this.emissionFactorService.listBySegment(2).subscribe(
            response => {
                this.emissionFactors = response
            }
        );
    }

    openNew() {
        this.mobile = new Mobile();
        this.submitted = false;
        this.mobileDialog = true;
    }

    editMobile(mobile: Mobile) {
        this.mobile = mobile;
        this.mobileDialog = true;
    }

    deleteMobile(mobile: Mobile) {
        this.deleteMobileDialog = true;
        this.mobile = {...mobile};
    }

    onChangeFuel(event) {
        if (this.mobile.amount != null && this.mobile.fuel != null) {
            this.calculateEmissions(this.mobile.fuel, this.mobile.amount)
        }
    }

    calculateEmissions(fuelId: number, amount: number) {
        this.mobileService.calculate(fuelId, amount).subscribe(
            response => {
                this.mobile.co2 = response.co2;
                this.mobile.ch4 = response.ch4;
                this.mobile.n2o = response.n2o;
            }
        );
    }

    confirmDelete(){
        
        this.mobileService.delete(this.mobile.mobileCombustionId).subscribe(
            () => {
                this.mobile = new Mobile()
                this.deleteMobileDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Mobile Combustion Deleted', life: 3000});
                this.mobile = new Mobile();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.mobileDialog = false;
        this.submitted = false;
    }

    saveMobile() {
        this.submitted = true;

        this.mobileService.save(this.mobile).subscribe(
            response => {
                this.mobile = response
                this.mobileDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Mobile Combustion saved', life: 3000});
                this.list()
            }
        );

    }

    
}
