import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionSegment } from '../emissionsegment/emissionsegment';
import { EmissionSegmentService } from '../emissionsegment/emissionsegmentservice';
import { EmissionType } from './emissiontype';
import { EmissionTypeService } from './emissiontypeservice';

@Component({
    templateUrl: './emissiontype.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class EmissionTypeComponent implements OnInit {

    emissionTypeDialog: boolean;

    deleteEmissionTypeDialog: boolean = false;

    emissionTypes: EmissionType[];

    emissionSegments: EmissionSegment[];

    emissionType: EmissionType;

    submitted: boolean;

    cols: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private emissionTypeService: EmissionTypeService, 
                private emissionSegmentService: EmissionSegmentService, 
                private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.listEmissionSegments();
        this.list();

        this.cols = [
            {field: 'name', header: 'Name'},
            {field: 'emissionSegment', header: 'Emission Segment'}
        ];

    }

    list() {
        this.emissionTypeService.list().subscribe(
            response => {
                this.emissionTypes = response
            }
        );
    }

    listEmissionSegments() {
        this.emissionSegmentService.list().subscribe(
            response => {
                this.emissionSegments = response
            }
        );
    }

    openNew() {
        this.emissionType = new EmissionType();
        this.submitted = false;
        this.emissionTypeDialog = true;
    }

    editEmissionType(emissionType: EmissionType) {
        this.emissionType = emissionType;
        this.emissionTypeDialog = true;
    }

    deleteEmissionType(emissionType: EmissionType) {
        this.deleteEmissionTypeDialog = true;
        this.emissionType = {...emissionType};
    }

    confirmDelete(){
        
        this.emissionTypeService.delete(this.emissionType.emissionTypeId).subscribe(
            () => {
                this.emissionType = new EmissionType()
                this.deleteEmissionTypeDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Type Deleted', life: 3000});
                this.emissionType = new EmissionType();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.emissionTypeDialog = false;
        this.submitted = false;
    }

    saveEmissionType() {
        this.submitted = true;

        this.emissionTypeService.save(this.emissionType).subscribe(
            response => {
                this.emissionType = response
                this.emissionTypeDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Type saved', life: 3000});
                this.list()
            }
        );

    }

    getEmissionSegmentName(emissionSegmentId: number) {
        let result = new EmissionSegment().name
        this.emissionSegments.forEach(element => {
            if (element.emissionSegmentId === emissionSegmentId) {
                result = element.name
            }
        });
        return result
    }
    
}
