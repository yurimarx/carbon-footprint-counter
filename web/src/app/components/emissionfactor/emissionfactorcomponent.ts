import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionSegment } from '../emissionsegment/emissionsegment';
import { EmissionType } from '../emissiontype/emissiontype';
import { EmissionTypeService } from '../emissiontype/emissiontypeservice';
import { EmissionUnit } from '../emissionunit/emissionunit';
import { EmissionUnitService } from '../emissionunit/emissionunitservice';
import { EmissionFactor } from './emissionfactor';
import { EmissionFactorService } from './emissionfactorservice';

@Component({
    templateUrl: './emissionfactor.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class EmissionFactorComponent implements OnInit {

    emissionFactorDialog: boolean;

    deleteEmissionFactorDialog: boolean = false;

    emissionFactors: EmissionFactor[];

    emissionTypes: EmissionType[];

    emissionUnits: EmissionUnit[];

    emissionFactor: EmissionFactor;

    submitted: boolean;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private emissionFactorService: EmissionFactorService, 
                private emissionTypeService: EmissionTypeService, 
                private emissionUnitService: EmissionUnitService, 
                private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.listEmissionTypes();
        this.listEmissionUnits();
        this.list();

        this.cols = [
            {field: 'name', header: 'Name'},
            {field: 'emissionSegment', header: 'Emission Segment'}
        ];

    }

    list() {
        this.emissionFactorService.list().subscribe(
            response => {
                this.emissionFactors = response
            }
        );
    }

    listEmissionTypes() {
        this.emissionTypeService.list().subscribe(
            response => {
                this.emissionTypes = response
            }
        );
    }

    listEmissionUnits() {
        this.emissionUnitService.list().subscribe(
            response => {
                this.emissionUnits = response
            }
        );
    }

    openNew() {
        this.emissionFactor = new EmissionFactor();
        this.submitted = false;
        this.emissionFactorDialog = true;
    }

    editEmissionFactor(emissionFactor: EmissionFactor) {
        this.emissionFactor = emissionFactor;
        this.emissionFactorDialog = true;
    }

    deleteEmissionFactor(emissionFactor: EmissionFactor) {
        this.deleteEmissionFactorDialog = true;
        this.emissionFactor = {...emissionFactor};
    }

    confirmDelete(){
        
        this.emissionFactorService.delete(this.emissionFactor.emissionFactorId).subscribe(
            () => {
                this.emissionFactor = new EmissionFactor()
                this.deleteEmissionFactorDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Type Deleted', life: 3000});
                this.emissionFactor = new EmissionFactor();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.emissionFactorDialog = false;
        this.submitted = false;
    }

    saveEmissionFactor() {
        this.submitted = true;

        this.emissionFactorService.save(this.emissionFactor).subscribe(
            response => {
                this.emissionFactor = response
                this.emissionFactorDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Type saved', life: 3000});
                this.list()
            }
        );

    }

    
}
