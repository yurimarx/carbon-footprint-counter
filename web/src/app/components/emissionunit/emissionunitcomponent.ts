import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionUnit } from './emissionunit';
import { EmissionUnitService } from './emissionunitservice';

@Component({
    templateUrl: './emissionunit.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class EmissionUnitComponent implements OnInit {

    emissionUnitDialog: boolean;

    deleteEmissionUnitDialog: boolean = false;

    emissionUnits: EmissionUnit[];

    emissionUnit: EmissionUnit;

    submitted: boolean;

    cols: any[];

    statuses: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private emissionUnitService: EmissionUnitService, private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.list()

        this.cols = [
            {field: 'name', header: 'Name'},
            {field: 'description', header: 'Description'}
        ];

    }

    list() {
        this.emissionUnitService.list().subscribe(
            response => {
                this.emissionUnits = response
            }
        );
    }

    openNew() {
        this.emissionUnit = new EmissionUnit();
        this.submitted = false;
        this.emissionUnitDialog = true;
    }

    editEmissionUnit(emissionUnit: EmissionUnit) {
        this.emissionUnit = emissionUnit;
        this.emissionUnitDialog = true;
    }

    deleteEmissionUnit(emissionUnit: EmissionUnit) {
        this.deleteEmissionUnitDialog = true;
        this.emissionUnit = {...emissionUnit};
    }

    confirmDelete(){
        
        this.emissionUnitService.delete(this.emissionUnit.emissionUnitId).subscribe(
            () => {
                this.emissionUnit = new EmissionUnit()
                this.deleteEmissionUnitDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Unit Deleted', life: 3000});
                this.emissionUnit = new EmissionUnit();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.emissionUnitDialog = false;
        this.submitted = false;
    }

    saveEmissionUnit() {
        this.submitted = true;

        this.emissionUnitService.save(this.emissionUnit).subscribe(
            response => {
                this.emissionUnit = response
                this.emissionUnitDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Unit saved', life: 3000});
                this.list()
            }
        );

    }
    
}
